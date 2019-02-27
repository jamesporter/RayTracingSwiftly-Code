import XCTest
@testable import LittleRayTracer

class TransformationTests: XCTestCase {
    func testTranslation() {
        let t = Transformation.translate(x: 2, y: 3, z: 4)
        let l = Vector4.point(1, 1, 1)
        let n = t * l
        XCTAssertEqual(n, Vector4.point(3,4,5))
    }
    
    func testScale() {
        let t = Transformation.scale(x: 2, y: 3, z: 4)
        let l = Vector4.point(1, 1, 1)
        let n = t * l
        XCTAssertEqual(n, Vector4.point(2,3,4))
    }
    
    func testRotX() {
        let t = Transformation.rotX(Constants.halfPi)
        let l = Vector4.point(3, 4, 1)
        let n = t * l
        XCTAssertEqual(n, Vector4.point(3,-1,4))
    }
    
    func testRotY() {
        let t = Transformation.rotY(Constants.halfPi)
        let l = Vector4.point(3, 4, 1)
        let n = t * l
        XCTAssertEqual(n, Vector4.point(1,4,-3))
    }
    
    func testRotZ() {
        let t = Transformation.rotZ(Constants.halfPi)
        let l = Vector4.point(3, 4, 1)
        let n = t * l
        XCTAssertEqual(n, Vector4.point(-4,3,1))
    }
    
    func testShear() {
        let t = Transformation.shear(xy: 1, xz: 0, yx: 0, yz: 0, zx: 0, zy: 0)
        let l = Vector4.point(2, 3, 4)
        let n = t * l
        XCTAssertEqual(n, Vector4.point(5,3,4))
        
        let t2 = Transformation.shear(xy: 0, xz: 1, yx: 0, yz: 0, zx: 0, zy: 0)
        let n2 = t2 * l
        XCTAssertEqual(n2, Vector4.point(6,3,4))
        
        let t3 = Transformation.shear(xy: 0, xz: 0, yx: 1, yz: 0, zx: 0, zy: 0)
        let n3 = t3 * l
        XCTAssertEqual(n3, Vector4.point(2,5,4))
        
        let t4 = Transformation.shear(xy: 0, xz: 0, yx: 0, yz: 1, zx: 0, zy: 0)
        let n4 = t4 * l
        XCTAssertEqual(n4, Vector4.point(2,7,4))
        
        let t5 = Transformation.shear(xy: 0, xz: 0, yx: 0, yz: 0, zx: 1, zy: 0)
        let n5 = t5 * l
        XCTAssertEqual(n5, Vector4.point(2,3,6))
        
        let t6 = Transformation.shear(xy: 0, xz: 0, yx: 0, yz: 0, zx: 0, zy: 1)
        let n6 = t6 * l
        XCTAssertEqual(n6, Vector4.point(2,3,7))
    }
    
    func testChained() {
        let t = Matrix.eye(4).rotatedX(Constants.halfPi).scaled(x: 5, y:5, z:5).translated(x: 10,y: 5,z: 7)
        let l = t * Vector4.point(1,0,1)
        XCTAssertEqual(l, Vector4.point(15,0,7))
    }
}
