import XCTest
@testable import LittleRayTracer

class VectorTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNormalise() {
        let a = Vector4.vector(1, 2, 3)
        XCTAssertEqual(1.0, a.normalised().magnitude(), accuracy: 0.0001)
    }
    
    func testDot() {
        let a = Vector4.vector(1, 2, 3)
        let b = Vector4.vector(2, 3, 4)
        XCTAssertEqual(20, a.dot(b), accuracy: 0.001)
    }
    
    func testCGFloatArrayDot() {
        let a: [CGFloat] = [1, 2, 3]
        let b: [CGFloat] = [2, 3, 4]
        XCTAssertEqual(20, a.dot(b), accuracy: Config.epsilon)
    }
    
    func testCrossProduct() {
        let a = Vector4.vector(1, 2, 3)
        let b = Vector4.vector(2, 3, 4)
        XCTAssertEqual(a.cross(b), Vector4.vector(-1, 2, -1))
        XCTAssertEqual(b.cross(a), Vector4.vector(1, -2, 1))
    }
}
