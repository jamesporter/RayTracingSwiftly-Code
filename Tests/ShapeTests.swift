import XCTest
@testable import LittleRayTracer

class ShapeTests: XCTestCase {
    func testPlaneBasics() {
        let p = Plane()
        XCTAssertEqual(p.normalAt(point: Vector4.point(0, 0, 0)), Vector4.vector(0, 1, 0))
        XCTAssertEqual(p.normalAt(point: Vector4.point(10, 0, -10)), Vector4.vector(0, 1, 0))
    }
    
    func testPlaneIntersectionI() {
        let p = Plane()
        let r = Ray(at: Vector4.point(0, 10, 0), inDirection: Vector4.vector(0,0, 1))
        XCTAssertEqual(p.intersectionsOf(ray: r).count, 0)
    }
    
    func testPlaneIntersectionII() {
        let p = Plane()
        let r = Ray(at: Vector4.point(0, 0, 0), inDirection: Vector4.vector(0,0, 1))
        XCTAssertEqual(p.intersectionsOf(ray: r).count, 0)
    }
    
    func testPlaneIntersectionIII() {
        let p = Plane()
        let r = Ray(at: Vector4.point(0, 1, 0), inDirection: Vector4.vector(0,-1, 0))
        let inters = p.intersectionsOf(ray: r)
        XCTAssertEqual(inters.count, 1)
        XCTAssertEqual(inters[0].time, 1.0, accuracy: Config.epsilon)
    }
    
    func testPlaneIntersectionVI() {
        let p = Plane()
        let r = Ray(at: Vector4.point(0, -1, 0), inDirection: Vector4.vector(0,1, 0))
        let inters = p.intersectionsOf(ray: r)
        XCTAssertEqual(inters.count, 1)
        XCTAssertEqual(inters[0].time, 1.0, accuracy: Config.epsilon)
    }
}
