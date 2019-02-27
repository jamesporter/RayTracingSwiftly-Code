import XCTest
@testable import LittleRayTracer

class ViewTransformationTests: XCTestCase {
    func testDefault() {
        XCTAssertEqual(ViewTransformations.viewTransform(from: Vector4.point(0, 0, 0), to: Vector4.point(0, 0, -1       ), up: Vector4.vector(0, 1, 0)) , Matrix.eye(4))
    }
    
    func testReverseOfDefault() {
        XCTAssertEqual(ViewTransformations.viewTransform(from: Vector4.point(0, 0, 0), to: Vector4.point(0, 0, 1       ), up: Vector4.vector(0, 1, 0)) , Transformation.scale(x: -1, y: 1, z: -1))
    }
    
    func testMoveWorldNotEye() {
        XCTAssertEqual(ViewTransformations.viewTransform(from: Vector4.point(0, 0, 8), to: Vector4.point(0, 0, 0       ), up: Vector4.vector(0, 1, 0)) , Transformation.translate(x: 0, y: 0, z: -8))
    }
    
    func testArbitrary() {
        let m = Matrix(fromRows:  [[-0.5070925528371099, 0.5070925528371099, 0.6761234037828132, -2.366431913239846], [0.7677159338596801, 0.6060915267313263, 0.12121830534626524, -2.8284271247461894], [-0.35856858280031806, 0.5976143046671968, -0.7171371656006361, 0.0], [0.0, 0.0, 0.0, 1.0]])
        XCTAssertEqual(ViewTransformations.viewTransform(from: Vector4.point(1,3, 2), to: Vector4.point(4, -2, 8       ), up: Vector4.vector(1, 1, 0)) , m)
    }
}
