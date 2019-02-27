import Cocoa

struct Vector4: Equatable {
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var w: CGFloat
    
    init(x: CGFloat, y: CGFloat, z: CGFloat, w: CGFloat) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    init(values: [CGFloat]) {
        self.x = values[0]
        self.y = values[1]
        self.z = values[2]
        self.w = values[3]
    }
    
    var cgV: [CGFloat] {
        get {
            return [x,y,z,w]
        }
    }

    static func ==(lhs: Vector4, rhs: Vector4) -> Bool {
        return abs(lhs.x - rhs.x) < Config.epsilon &&
                abs(lhs.y - rhs.y) < Config.epsilon &&
                abs(lhs.z - rhs.z) < Config.epsilon &&
                abs(lhs.w - rhs.w) < Config.epsilon
    }
    
    static func point(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> Vector4 {
        return Vector4(x: x, y:y, z:z, w: 1.0)
    }
    
    static func vector(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> Vector4 {
        return Vector4(x: x, y:y, z:z, w: 0.0)
    }
    
    func negated() -> Vector4 {
        return Vector4(x: -x, y: -y, z: -z, w: -w)
    }
    
    func scaledBy(_ s: CGFloat) -> Vector4 {
        return Vector4(x: x * s, y: y * s, z: z * s, w: w * s)
    }
    
    func dividedBy(_ d: CGFloat) -> Vector4 {
        return Vector4(x: x / d, y: y / d, z: z / d, w: w / d)
    }
    
    func magnitude() -> CGFloat {
        return sqrt(x * x + y * y + z * z + w * w)
    }
    
    func normalised() -> Vector4 {
        let m = magnitude()
        return dividedBy(m)
    }
    
    func dot(_ other: Vector4) -> CGFloat {
        return x * other.x + y * other.y + z * other.z + w * other.w
    }
    
    func cross(_ other: Vector4) -> Vector4 {
        return Vector4.vector(y * other.z - z * other.y, z * other.x - x * other.z, x * other.y - y * other.x)
    }
    
    func reflect(in other: Vector4) -> Vector4 {
        let n = other.normalised()
        return self - n * (2 * self.dot(n))
    }
    
    static func *(lhs: Vector4, rhs: CGFloat) -> Vector4 {
        return lhs.scaledBy(rhs)
    }
}


func + (left: Vector4, right: Vector4) -> Vector4 {
    return Vector4(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z, w: left.w + right.w)
}

func - (left: Vector4, right: Vector4) -> Vector4 {
    return Vector4(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z, w: left.w - right.w)
}
