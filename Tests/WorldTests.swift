import XCTest
@testable import LittleRayTracer

class WorldTests: XCTestCase {
    func testIntersections() {
        let w = World.createDefault()
        let r = Ray(at: Vector4.point(0,0,-5), inDirection: Vector4.vector(0,0,1))
        
        let inters = r.intersectionsIn(world: w)
        XCTAssertEqual(inters.count, 4)
        XCTAssertEqual(inters[0].time, 4.0, accuracy: Config.epsilon)
        XCTAssertEqual(inters[1].time, 4.5, accuracy: Config.epsilon)
        XCTAssertEqual(inters[2].time, 5.5, accuracy: Config.epsilon)
        XCTAssertEqual(inters[3].time, 6.0, accuracy: Config.epsilon)
    }
    
    func testComputations() {
        let r = Ray(at: Vector4.point(0,0,-5), inDirection: Vector4.vector(0,0,1))
        let s = Sphere()
        let i = s.intersectionsOf(ray: r)[0]
        let c = r.intersectionComp(for: (i.time, i.at, s))
        XCTAssertEqual(c.t, i.time)
        XCTAssertFalse(c.inside)
        XCTAssertEqual(c.normal, Vector4.vector(0, 0, -1))
    }
    
    func testComputationsInside() {
        let r = Ray(at: Vector4.point(0,0,0), inDirection: Vector4.vector(0,0,1))
        let s = Sphere()
        let h = r.hit(object: s)
        if let i = h {
            let c = r.intersectionComp(for: (i.time, i.at, s))
            XCTAssertEqual(c.t, i.time)
            XCTAssertTrue(c.inside)
            XCTAssertEqual(c.normal, Vector4.vector(0, 0, -1))
        } else {
            XCTFail("Should be a hit")
        }
    }
    
    func testComputationsOverPoint() {
        let r = Ray(at: Vector4.point(0,0,-5), inDirection: Vector4.vector(0,0,1))
        var s = Sphere()
        s.transformation = Transformation.translate(x: 0, y: 0, z: 1)
        
        if let i = r.hit(object: s) {
            let c = r.intersectionComp(for: (i.time, i.at, s))
            XCTAssert(c.overPoint.z < -Config.epsilon/2)
            XCTAssert(c.point.z > c.overPoint.z)
        } else {
            XCTFail("Should be a hit")
        }
    }
    
    func testShadingWorldExample () {
        let w = World.createDefault()
        let r = Ray(at: Vector4.point(0, 0, -5), inDirection: Vector4.vector(0, 0, 1))
        let s = w.objects[0]
        let i = s.intersectionsOf(ray: r)[0]
        let c = r.intersectionComp(for: (i.time, i.at, s))
        let shadedRes = LightCalculations.shade(in: w, at: c, remaining: Config.defaultRemaining)
        XCTAssertEqual(shadedRes, Colour(0.38066, 0.47583, 0.2855))
    }
    
    func testShadingWorldInsideExample () {
        var w = World.createDefault()
        w.light = Light(position: Vector4.point(0, 0.25, 0), intensity: Colour.white)
        let r = Ray(at: Vector4.point(0, 0, 0), inDirection: Vector4.vector(0, 0, 1))
        let s = w.objects[1]
        let i = s.intersectionsOf(ray: r)[1]
        let c = r.intersectionComp(for: (i.time, i.at, s))
        let shadedRes = LightCalculations.shade(in: w, at: c, remaining: Config.defaultRemaining)
        XCTAssertEqual(shadedRes, Colour(0.9049844720832575, 0.9049844720832575, 0.9049844720832575))
    }
    
    func testColourAtMiss() {
        let w = World.createDefault()
        let r = Ray(at: Vector4.point(0, 0, -5), inDirection: Vector4.vector(0, 1, 0))
        let c = LightCalculations.colourFor(ray: r, in: w, remaining: Config.defaultRemaining)
        XCTAssertEqual(c, Colour.black)
    }
    
    func testColourAt() {
        let w = World.createDefault()
        let r = Ray(at: Vector4.point(0, 0, -5), inDirection: Vector4.vector(0, 0, 1))
        let c = LightCalculations.colourFor(ray: r, in: w, remaining: Config.defaultRemaining)
        XCTAssertEqual(c, Colour(0.38066119308103435, 0.47582649135129296, 0.28549589481077575))
    }
    
    func testRender() {
        var w = World.createDefault()
        var c = Camera(w: 11, h: 11, fov: CGFloat.pi/2)
        c.transform = ViewTransformations.viewTransform(from: Vector4.point(0,0,-5), to: Vector4.point(0,0,0), up: Vector4.vector(0,1,0))
        w.camera = c
        let canvas = w.render()!
        XCTAssertEqual(canvas[5,5], Colour(0.38066119308103435, 0.47582649135129296, 0.28549589481077575))
    }
    
    func testShadingWorldWithShadowExample () {
        var w = World()
        w.light = Light(position: Vector4.point(0, 0, -10), intensity: Colour(1,1,1))
        
        let s = Sphere()
        w.objects.append(s)
        
        var s2 = Sphere()
        s2.transformation = Transformation.translate(x: 0, y: 0, z: 10)
        w.objects.append(s2)
        
        let r = Ray(at: Vector4.point(0, 0, 5), inDirection: Vector4.vector(0, 0, 1))
        
        let i = s2.intersectionsOf(ray: r)[1]
        
        let c = r.intersectionComp(for: (i.time, i.at, s))
        let shadedRes = LightCalculations.shade(in: w, at: c, remaining: Config.defaultRemaining)
        XCTAssertEqual(shadedRes, Colour(0.1, 0.1, 0.1))
    }
}
