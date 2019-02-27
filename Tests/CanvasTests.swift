import XCTest
@testable import LittleRayTracer

class CanvasTests: XCTestCase {
    func testCanvasCreation() {
        let c = Canvas(w: 4, h: 5)
        c.pixels.forEach {
            XCTAssertEqual($0, Colour())
        }
    }
    
    func testToPPM() {
        let c = Canvas(w: 4, h: 5)
        XCTAssertEqual(c.ppm, """
            P3
            4 5
            255
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            
            """)
    }
    
    func testWritingColours() {
        var c = Canvas(w: 4, h: 5)
        c[1,1] = Colour(1.0, 0.5, 1.0)
        XCTAssertEqual(c.ppm, """
            P3
            4 5
            255
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 255 128 255 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            
            """)
    }
}
