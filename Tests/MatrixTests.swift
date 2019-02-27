import XCTest
@testable import LittleRayTracer

class MatrixTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreationAndBasics() {
        var a = Matrix(size: 3)
        XCTAssertEqual(a[1,1], 0.0, accuracy: 0.0001)
        a[2,0] = 2.0
        XCTAssertEqual(a[2,0], 2.0, accuracy: 0.0001)
        
        var b = Matrix(size: 4)
        XCTAssertEqual(b[1,3], 0.0, accuracy: 0.0001)
        b[3,2] = 1.0
        XCTAssertEqual(b[3,2], 1.0, accuracy: 0.0001)
    }
    
    func testExplicitInit() {
        var a = Matrix(fromRows: [
            [1,2,3],
            [4,5,6],
            [7,8,9],
            ])
        XCTAssertEqual(a![1,2], 6.0, accuracy: 0.0001)
    }
    
    func testEquality() {
        let a = Matrix(fromRows: [[1,2], [3,4]])!
        let b = Matrix(fromRows: [[1.00000000001, 1.9999999999999], [3, 4.00000000001]])!
        XCTAssertEqual(a,b)
    }
    
    func testMultiplication() {
        let a = Matrix(fromRows: [[1,2], [3,4]])!
        let b = Matrix(fromRows: [[7,10], [15,22]])!
        XCTAssertEqual(a * a, b)
        
        let a2 = Matrix(fromRows: [[1,0,0], [0,1,0], [0,0,1]])!
        XCTAssertEqual(a2 * a2, a2)
    }
    
    func testMatricAndVectorMultiplication() {
        let a = Matrix(fromRows: [
            [1,2,3,4],
            [2,4,4,2],
            [8,6,4,1],
            [0,0,0,1],
            ])!
        let v = Vector4(x: 1, y: 2, z: 3, w: 1)
        
        XCTAssertEqual(a * v, Vector4(x: 18, y: 24, z: 33, w: 1))
    }
    
    func testIdentity() {
        let e = Matrix.eye(4)
        
        let v = Vector4(x: 1, y: 2, z: 3, w: 1)
        
        XCTAssertEqual(e * v, v)
        XCTAssertEqual(e * e, e)

        var b = Matrix(size: 4)
        b[1,2] = 3
        b[1,3] = 8
        b[2,0] = 6
        b[3,1] = 5
        b[1,2] = -2
        
        XCTAssertEqual(e * b, b)
        XCTAssertEqual(b * e, b)
        
    }
    
    func testTranspose() {
        let m = Matrix(fromRows: [[0,2], [1,0]])!
        let mT = Matrix(fromRows: [[0,1], [2,0]])!
        
        XCTAssertEqual(m.transposed(), mT)
    }
    
    func testDeterminant() {
        XCTAssertEqual(Matrix.eye(4).determinant(), 1.0, accuracy: 0.00001)
        
        let a = Matrix(fromRows: [[1,2], [3,4]])!
        XCTAssertEqual(a.determinant(), -2.0, accuracy: 0.00001)
        
        let b = Matrix(fromRows: [[1,2,3], [3,4,5], [3,4,8]])!
        XCTAssertEqual(b.determinant(), -6.0, accuracy: 0.00001)
    }
    
    func testInverse() {
        let e = Matrix.eye(2)
        XCTAssertEqual(e.inverted(), e)
        
        let b = Matrix(fromRows: [[1,2,3], [3,4,5], [3,4,8]])!
        let bi = Matrix(fromRows: [[-12,4,2], [9,1,-4], [0,-2,2]])! * (1/6.0)
        XCTAssertEqual(b.inverted(), bi)
            
        let c = Matrix(fromRows: [[1,2,3,4],[2,3,4,5],[4,5,6,-7],[3,-4,6,9]])!
        let ci = Matrix(fromRows: [[-490,357,-7,14],[-6,51,-3,-28],[292,-221,27,14],[-34,51,-17,0]])! * (1/238)
        XCTAssertEqual(c.inverted(), ci)
    }
}
