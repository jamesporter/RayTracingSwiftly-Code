import Foundation

enum ViewTransformations {
    static func viewTransform(from: Vector4, to: Vector4, up: Vector4) -> Matrix {
        let forward = (to - from).normalised()
        let upN = up.normalised()
        let left = forward.cross(upN)
        let trueUp = left.cross(forward)
        
        let orientation = Matrix(fromRows: [
            [left.x, left.y, left.z, 0],
            [trueUp.x, trueUp.y, trueUp.z, 0],
            [-forward.x, -forward.y, -forward.z, 0],
            [0, 0, 0, 1]])!
        
        return orientation * Transformation.translate(x: -from.x, y: -from.y, z: -from.z)
    }
}
