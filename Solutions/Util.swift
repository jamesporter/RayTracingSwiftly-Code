import Cocoa

extension Int {
    func clamped(low: Int = 0, high: Int = 255) -> Int {
        if self < low {
            return low
        } else if self > high {
            return high
        } else {
            return self
        }
    }
    
    var f: CGFloat {
        get {
            return CGFloat(self)
        }
    }
}

extension CGFloat {
    func toIntScaledBy(_ scale: CGFloat = 255 ) -> Int {
        return Int((self * scale).rounded())
    }
}

extension Array {
    func chunked(_ size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension Array where Element : FloatingPoint {
    static func *(lhs: Array<Element>, rhs: Array<Element>) -> Array<Element> {
        return zip(lhs, rhs).map { $0.0 * $0.1 }
    }
    
    func dot(_ other: Array<Element>) -> Element {
        return zip(self, other).reduce(Element(0)) { $0 + $1.0 * $1.1 }
    }
}

