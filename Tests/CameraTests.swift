import XCTest
@testable import LittleRayTracer

class CameraTests: XCTestCase {
    func testExample() {
        let c = Camera(w: 160, h: 120, fov: CGFloat.pi/2)
        XCTAssertEqual(c.transform, Matrix.eye(4))
    }
    
    func testPixelSizes() {
        let c = Camera(w: 200, h: 125, fov: CGFloat.pi/2)
        XCTAssertEqual(c.pixelSize, 0.01, accuracy: 0.0001)
        
        let c2 = Camera(w: 125, h: 200, fov: CGFloat.pi/2)
        XCTAssertEqual(c2.pixelSize, 0.01, accuracy: 0.0001)
    }
    
    func testRaysI() {
        let c = Camera(w: 201, h: 101, fov: CGFloat.pi/2)
        let r: Ray = c[100, 50]
        XCTAssertEqual(r.origin, Vector4.point(0, 0, 0))
        XCTAssertEqual(r.direction, Vector4.vector(0, 0, -1))
    }
    
    func testRaysII() {
        let c = Camera(w: 201, h: 101, fov: CGFloat.pi/2)
        let r: Ray = c[0, 0]
        XCTAssertEqual(r.origin, Vector4.point(0, 0, 0))
        XCTAssertEqual(r.direction, Vector4.vector(0.66519, 0.33259, -0.66851))
    }
    
    func testRaysIII() {
        var c = Camera(w: 201, h: 101, fov: CGFloat.pi/2)
        c.transform = Transformation.rotY(CGFloat.pi/4) * Transformation.translate(x: 0, y: -2, z: 5)
        let r: Ray = c[100, 50]
        XCTAssertEqual(r.origin, Vector4.point(0, 2, -5))
        XCTAssertEqual(r.direction, Vector4.vector(sqrt(2)/2, 0, -sqrt(2)/2))
    }
}
