import Cocoa

enum Transformation {
    static func translate(x: CGFloat, y: CGFloat, z: CGFloat) -> Matrix {
        var t = Matrix.eye(4)
        t[0,3] = x
        t[1,3] = y
        t[2,3] = z
        return t
    }
    
    static func scale(x: CGFloat, y: CGFloat, z: CGFloat) -> Matrix {
        var t = Matrix.eye(4)
        t[0,0] = x
        t[1,1] = y
        t[2,2] = z
        return t
    }
    
    static func shear(xy: CGFloat, xz: CGFloat, yx: CGFloat, yz: CGFloat, zx: CGFloat, zy: CGFloat) -> Matrix {
        var t = Matrix.eye(4)
        t[0,1] = xy
        t[0,2] = xz
        t[1,0] = yx
        t[1,2] = yz
        t[2,0] = zx
        t[2,1] = zy
        return t
    }
    
    static func rotX(_ angle: CGFloat) -> Matrix {
        var m = Matrix.eye(4)
        let c = cos(angle)
        let s = sin(angle)
        m[1,1] = c
        m[1,2] = -s
        m[2,1] = s
        m[2,2] = c
        return m
    }
    
    static func rotY(_ angle: CGFloat) -> Matrix {
        var m = Matrix.eye(4)
        let c = cos(angle)
        let s = sin(angle)
        m[0,0] = c
        m[0,2] = s
        m[2,0] = -s
        m[2,2] = c
        return m
    }
    
    static func rotZ(_ angle: CGFloat) -> Matrix {
        var m = Matrix.eye(4)
        let c = cos(angle)
        let s = sin(angle)
        m[0,0] = c
        m[0,1] = -s
        m[1,0] = s
        m[1,1] = c
        return m
    }
}
