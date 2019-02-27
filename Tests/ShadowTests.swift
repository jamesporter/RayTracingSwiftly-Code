import XCTest
@testable import LittleRayTracer

class ShadowTests: XCTestCase {
    func testOne() {
        let w = World.createDefault()
        let p = Vector4.point(0,10, 0)
        XCTAssertFalse(LightCalculations.isInShadow(p, world: w))
    }
    
    func testTwo() {
        let w = World.createDefault()
        let p = Vector4.point(10,-10, 10)
        XCTAssertTrue(LightCalculations.isInShadow(p, world: w))
    }
    
    func testThree() {
        let w = World.createDefault()
        let p = Vector4.point(-20,20, -20)
        XCTAssertFalse(LightCalculations.isInShadow(p, world: w))
    }
    
    func testFour() {
        let w = World.createDefault()
        let p = Vector4.point(-2,2, -2)
        XCTAssertFalse(LightCalculations.isInShadow(p, world: w))
    }
}
