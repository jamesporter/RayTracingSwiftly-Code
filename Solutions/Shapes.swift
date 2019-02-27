import Cocoa

protocol Shape {
    var material: Material { get set }
    var transformation: Matrix { get set }
    func normalAt(point: Vector4) -> Vector4
    func intersectionsOf(ray: Ray) -> [(time: CGFloat, at: Vector4)]
}

struct Sphere : Shape {
    var transformation = Matrix.eye(4) {
        didSet {
            invertedTransformation = transformation.inverted()
            invertedTransformationTranspose = invertedTransformation.transposed()
        }
    }
    private var invertedTransformation = Matrix.eye(4)
    private var invertedTransformationTranspose = Matrix.eye(4)
    
    var material = Material()
    
    func normalAt(point: Vector4) -> Vector4 {
        let objectPoint = invertedTransformation * point
        let objectNormal = objectPoint - Vector4.point(0, 0, 0)
        var worldNormal = invertedTransformationTranspose * objectNormal
        worldNormal.w = 0
        return worldNormal.normalised()
    }
    
    func intersectionsOf(ray: Ray) -> [(time: CGFloat, at: Vector4)] {
        let r = ray.transformed(by: invertedTransformation)
        
        let sToR = r.origin - Vector4.point(0, 0, 0)
        let a = r.direction.dot(r.direction)
        let b = 2 * r.direction.dot(sToR)
        let c = sToR.dot(sToR) - 1
        
        let d = b * b - 4 * a * c
        
        if d < 0 {
            return []
        } else {
            let t1 = (-b - sqrt(d))/(2 * a)
            let t2 = (-b + sqrt(d))/(2 * a)
            
            return [
                ( time: t1, at: ray.position(atTime: t1)),
                ( time: t2, at: ray.position(atTime: t2)),
            ]
        }
    }
}

struct Plane : Shape {
    func normalAt(point: Vector4) -> Vector4 {
        var worldNormal = invertedTransformationTranspose * Vector4.vector(0, 1, 0)
        worldNormal.w = 0
        return worldNormal.normalised()
    }
    
    func intersectionsOf(ray: Ray) -> [(time: CGFloat, at: Vector4)] {
        let r = ray.transformed(by: invertedTransformation)
        
        if abs(r.direction.y) < Config.epsilon {
            return []
        }
        let t = -r.origin.y / r.direction.y
        return [(t, ray.position(atTime: t))]
    }
    
    var transformation = Matrix.eye(4) {
        didSet {
            invertedTransformation = transformation.inverted()
            invertedTransformationTranspose = invertedTransformation.transposed()
        }
    }
    private var invertedTransformation = Matrix.eye(4)
    private var invertedTransformationTranspose = Matrix.eye(4)
    
    var material = Material()
}
