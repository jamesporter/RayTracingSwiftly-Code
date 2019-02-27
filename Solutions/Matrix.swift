import Cocoa

enum MatrixError: Error {
    case invalidSizeInput(message: String)
}

struct Matrix : Equatable {
    private var data: [CGFloat]
    let size: Int
    
    init(size: Int) {
        self.size = size
        data = [CGFloat].init(repeating: 0.0, count: size * size)
    }
    
    init?(fromRows rows: [[CGFloat]]) {
        if rows.count == 0 || rows[0].count == 0 {
            // TODO expand to check sizes same
            return nil
        }
        size = rows.count
        data = rows.flatMap { $0 }
    }
    
    subscript(r: Int, c: Int) -> CGFloat {
        get {
            return data[size * r + c]
        }
        
        set {
            data[size * r + c] = newValue
        }
    }
    
    var rows: [[CGFloat]] {
        get {
            return data.chunked(size)
        }
    }
    
    static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        if lhs.size != rhs.size {
            return false
        }
        
        return zip(lhs.data, rhs.data).allSatisfy { abs($0.0 - $0.1) < Config.epsilon }
    }
    
    static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        if lhs.size != rhs.size {
            print("Sizes of matrices don't match")
        }
        
        var res = Matrix(size: lhs.size)
        
        for i in 0..<lhs.size {
            for j in 0..<lhs.size {
                var sum: CGFloat = 0
                for k in 0..<lhs.size {
                    sum += lhs[i,k] * rhs[k,j]
                }
                res[i,j] = sum
            }
        }
        return res
    }
    
    static func *(lhs: Matrix, rhs: Vector4) -> Vector4 {
        if lhs.size != 4 {
            print("Sizes of matrix must be 4")
        }
        let v = rhs.cgV
        return Vector4(values: lhs.rows.map {
            row in
            row.dot(v)
        })
    }
    
    static func *(lhs: Matrix, rhs: CGFloat) -> Matrix {
        return lhs.map { $0 * rhs }
    }
    
    static func eye(_ size: Int) -> Matrix {
        var m = Matrix(size: size)
        for k in 0..<size {
            m[k,k] = 1
        }
        return m
     }
    
    func transposed() -> Matrix {
        var res = Matrix(size: size)
        for i in 0..<size {
            for j in 0..<size {
                res[i,j] = self[j,i]
            }
        }
        return res
    }
    
    func subMatrix(withoutRow row: Int, column: Int) -> Matrix {
        var res = Matrix(size: size - 1)
        for i in 0..<res.size {
            for j in 0..<res.size {
                let iIdx = i < row ? i : i + 1
                let jIdx = j < column ? j : j + 1
                res[i,j] = self[iIdx, jIdx]
            }
        }
        return res
    }
    
    
    func determinant() -> CGFloat {
        if size == 1 {
            return self[0,0]
        } else {
            var sum: CGFloat = 0
            var multiplier: CGFloat = 1.0
            let topRow = rows[0]
            for (column, num) in topRow.enumerated() {
                let sm = subMatrix(withoutRow: 0, column: column)
                sum += num * multiplier * sm.determinant()
                multiplier *= -1.0
            }
            return sum
        }
    }
    
    func map(transform: (CGFloat) -> CGFloat) -> Matrix {
        var res = Matrix(size: size)
        for i in 0..<size {
            for j in 0..<size {
                res[i,j] = transform(self[i,j])
            }
        }
        return res
    }
    
    func map(transform: (CGFloat, Int, Int) -> CGFloat) -> Matrix {
        var res = Matrix(size: size)
        for i in 0..<size {
            for j in 0..<size {
                res[i,j] = transform(self[i,j], i, j)
            }
        }
        return res
    }
    
    func cofactors() -> Matrix {
        return map { v, r, c in
            let sign: CGFloat = ((r + c) % 2 == 0) ? 1 : -1
            return sign * self.subMatrix(withoutRow: r, column: c).determinant()
        }
    }
    
    func inverted() -> Matrix {
        return cofactors().transposed() * (1/determinant())
    }
    
    func translated(x: CGFloat, y: CGFloat, z: CGFloat) -> Matrix {
        return Transformation.translate(x:x, y:y, z:z) * self
    }
    
    func scaled(x: CGFloat, y: CGFloat, z: CGFloat) -> Matrix {
        return Transformation.scale(x:x, y:y, z:z) * self
    }
    
    func sheared(xy: CGFloat, xz: CGFloat, yx: CGFloat, yz: CGFloat, zx: CGFloat, zy: CGFloat) -> Matrix {
        return Transformation.shear(xy: xy, xz: xz, yx: yx, yz: yz, zx: zx, zy: zy) * self
    }
    
    func rotatedX(_ angle: CGFloat) -> Matrix {
        return Transformation.rotX(angle) * self
    }
    
    func rotatedY(_ angle: CGFloat) -> Matrix {
        return Transformation.rotY(angle) * self
    }
    
    func rotatedZ(_ angle: CGFloat) -> Matrix {
        return Transformation.rotZ(angle) * self
    }
}

