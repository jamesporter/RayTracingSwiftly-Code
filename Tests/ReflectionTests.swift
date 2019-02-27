import XCTest
@testable import LittleRayTracer

class ReflectionTests: XCTestCase {
    func testAttribute() {
        let m = Material()
        XCTAssertEqual(m.reflective, 0.0, accuracy: Config.epsilon)
    }
    
    func testReflectionVector() {
        let p: Shape = Plane()
        let r = Ray(at: Vector4.point(0, 1, -1), inDirection: Vector4.vector(0, -sqrt(2)/2, sqrt(2)/2))
        let i = p.intersectionsOf(ray: r)[0]
        let comps = r.intersectionComp(for: (time: i.time, at: i.at, object: p))
        XCTAssertEqual(comps.reflection, Vector4.vector(0, sqrt(2)/2, sqrt(2)/2))
    }
    
    func testNonReflection() {
        let w = World.createDefault()
        let r = Ray(at: Vector4.point(0,0,0), inDirection: Vector4.vector(0, 0, 1))
        var s = w.objects[1]
        s.material.ambient = 1
        let i = s.intersectionsOf(ray: r)[0]
        let comps = r.intersectionComp(for: (time: i.time, at: i.at, object: s))
        let c = LightCalculations.reflectedColourFor(comps, in: w, remaining: Config.defaultRemaining)
        XCTAssertEqual(c, Colour(0,0,0))
    }
    
    func testReflectionCalc() {
        var w = World.createDefault()
        var p = Plane()
        p.material.reflective = 0.5
        p.transformation = Transformation.translate(x: 0,y: -1,z: 0)
        w.objects.append(p)
        
        let r = Ray(at: Vector4.point(0,0,-3), inDirection: Vector4.vector(0, -sqrt(2)/2, sqrt(2)/2))
        
        let i = p.intersectionsOf(ray: r)[0]
        
        let comps = r.intersectionComp(for: (time: i.time, at: i.at, object: p))
        let c = LightCalculations.reflectedColourFor(comps, in: w, remaining: 3)
        XCTAssertEqual(c, Colour(0.19034783498676108, 0.23793479373345133, 0.142760876240070))
    }
    
    func testShading() {
        var w = World.createDefault()
        var p = Plane()
        p.material.reflective = 0.5
        p.transformation = Transformation.translate(x: 0,y: -1,z: 0)
        w.objects.append(p)
        
        let r = Ray(at: Vector4.point(0,0,-3), inDirection: Vector4.vector(0, -sqrt(2)/2, sqrt(2)/2))
        
        let i = p.intersectionsOf(ray: r)[0]
        
        let comps = r.intersectionComp(for: (time: i.time, at: i.at, object: p))
        let c = LightCalculations.shade(in: w, at: comps, remaining: Config.defaultRemaining)
        XCTAssertEqual(c, Colour(0.8767732239682625, 0.9243601827149528, 0.8291862652215722))
    }
    
    func testAvoidInfiniteRecursion() {
        var w = World.createDefault()
        var p = Plane()
        p.material.reflective = 0.5
        p.transformation = Transformation.translate(x: 0,y: -1,z: 0)
        w.objects.append(p)
        
        let r = Ray(at: Vector4.point(0,0,-3), inDirection: Vector4.vector(0, -sqrt(2)/2, sqrt(2)/2))
        
        let i = p.intersectionsOf(ray: r)[0]
        
        let comps = r.intersectionComp(for: (time: i.time, at: i.at, object: p))
        let c = LightCalculations.reflectedColourFor(comps, in: w, remaining: 0)
        XCTAssertEqual(c, Colour(0,0,0))
    }
}
