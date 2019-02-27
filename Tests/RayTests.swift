import XCTest
@testable import LittleRayTracer

class RayTests: XCTestCase {
    func testPositionAtT() {
        let r = Ray(at: Vector4.point(0, 0, 0), inDirection: Vector4.vector(2, 4, 5))
        
        XCTAssertEqual(r.position(atTime: 2), Vector4.point(4,8,10))
        XCTAssertEqual(r.position(atTime: -2), Vector4.point(-4,-8,-10))
        XCTAssertEqual(r.position(atTime: 5), Vector4.point(10,20,25))
    }
    
    func testSphereIntersections() {
        let r = Ray(at: Vector4.point(0, 0, -5), inDirection: Vector4.vector(0, 0, 1))
        let s = Sphere()
        let inters = s.intersectionsOf(ray: r)
        
        XCTAssertEqual(inters[0].at, Vector4.point(0, 0, -1))
        XCTAssertEqual(inters[0].time, 4)
        XCTAssertEqual(inters[1].at, Vector4.point(0, 0, 1))
        XCTAssertEqual(inters[1].time, 6)
        
        let r2 = Ray(at: Vector4.point(0, 4, -5), inDirection: Vector4.vector(0, 0, 1))
        let inters2 = s.intersectionsOf(ray: r2)
        XCTAssertEqual(inters2.count, 0)
    }
    
    func testSphereHit() {
        let r = Ray(at: Vector4.point(0, 0, -5), inDirection: Vector4.vector(0, 0, 1))
        let s = Sphere()
        let h = r.hit(object: s)
        
        XCTAssertEqual(h?.at, Vector4.point(0, 0, -1))
        XCTAssertEqual(h?.time, 4)
        
        let r2 = Ray(at: Vector4.point(0, 4, -5), inDirection: Vector4.vector(0, 0, 1))
        let h2 = r2.hit(object: s)
        XCTAssertNil(h2)
    }
    
    func testTranslate() {
        let r = Ray(at: Vector4.point(1, 2, 3), inDirection: Vector4.vector(0, 1, 0))
        let rt = r.transformed(by: Transformation.translate(x: 3, y: 4, z: 5))
        XCTAssertEqual(rt.origin, Vector4.point(4, 6, 8))
        XCTAssertEqual(rt.direction, Vector4.vector(0,1,0))
    }
    
    func testScale() {
        let r = Ray(at: Vector4.point(1, 2, 3), inDirection: Vector4.vector(0, 1, 0))
        let rt = r.transformed(by: Transformation.scale(x: 2, y: 3, z: 4))
        XCTAssertEqual(rt.origin, Vector4.point(2, 6, 12))
        XCTAssertEqual(rt.direction, Vector4.vector(0,3,0))
    }
    
    func testSphereIntersectionsWithTransformation() {
        let r = Ray(at: Vector4.point(0, 0, -5), inDirection: Vector4.vector(0, 0, 1))
        var s = Sphere()
        s.transformation = Transformation.scale(x: 2, y: 2, z: 2)
        let inters = s.intersectionsOf(ray: r)
        
        XCTAssertEqual(inters[0].at, Vector4.point(0, 0, -2))
        XCTAssertEqual(inters[0].time, 3)
        XCTAssertEqual(inters[1].at, Vector4.point(0, 0, 2))
        XCTAssertEqual(inters[1].time, 7)
        
        let r2 = Ray(at: Vector4.point(0, 0, -5), inDirection: Vector4.vector(0, 0, 1))
        s.transformation = Transformation.translate(x: 5, y: 0, z: 0)
        let inters2 = s.intersectionsOf(ray: r2)
        XCTAssertEqual(inters2.count, 0)
    }
}
