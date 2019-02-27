import XCTest
@testable import LittleRayTracer

class LightTests: XCTestCase {
    func testSimpleLightCalculation() {
        let c = LightCalculations.lighting(material: Material(), light: Light(position: Vector4.point(0,0,-10), intensity: Colour(1,1,1)), position: Vector4.point(0,0,0), eye: Vector4.point(0,0,-1), normal: Vector4.vector(0,0,-1), inShadow: false)
        XCTAssertEqual(c, Colour(1.9,1.9,1.9))
    }
    
    func testLightCalculationI() {
        let c = LightCalculations.lighting(material: Material(), light: Light(position: Vector4.point(0,0,-10), intensity: Colour(1,1,1)), position: Vector4.point(0,0,0), eye: Vector4.point(0, sqrt(2)/2, sqrt(2)/2), normal: Vector4.vector(0,0,-1), inShadow: false)
        XCTAssertEqual(c, Colour(1.0,1.0,1.0))
    }
    
    func testLightCalculationII() {
        let c = LightCalculations.lighting(material: Material(), light: Light(position: Vector4.point(0,10,-10), intensity: Colour(1,1,1)), position: Vector4.point(0,0,0), eye: Vector4.point(0, 0, -1), normal: Vector4.vector(0,0,-1), inShadow: false)
        XCTAssertEqual(c, Colour(0.7364,0.7364,0.7364))
    }
    
    func testLightCalculationIII() {
        let eyeV = Vector4.point(0, -sqrt(2)/2, -sqrt(2)/2)
        let normalV = Vector4.vector(0,0,-1)
        let light = Light(position: Vector4.point(0,10,-10), intensity: Colour(1,1,1))
        let p = Vector4.point(0,0,0)
        let m = Material()
        
        let c = LightCalculations.lighting(material: m, light: light, position: p, eye: eyeV, normal: normalV, inShadow: false)
        XCTAssertEqual(c, Colour(1.6363961030, 1.6363961030, 1.6363961030))
    }
    
    func testLightCalculationIV() {
        let c = LightCalculations.lighting(material: Material(), light: Light(position: Vector4.point(0,0,10), intensity: Colour(1,1,1)), position: Vector4.point(0,0,0), eye: Vector4.point(0, 0, -1), normal: Vector4.vector(0,0,-1), inShadow: false)
        XCTAssertEqual(c, Colour(0.1, 0.1, 0.1))
    }
    
    func testShadow() {
        let c = LightCalculations.lighting(material: Material(), light: Light(position: Vector4.point(0,0,-10), intensity: Colour(1,1,1)), position: Vector4.point(0,0,0), eye: Vector4.point(0, 0, -1), normal: Vector4.vector(0,0,-1), inShadow: true)
        XCTAssertEqual(c, Colour(0.1, 0.1, 0.1))
    }
}
