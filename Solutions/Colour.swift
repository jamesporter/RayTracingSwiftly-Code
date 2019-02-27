import Cocoa

struct Colour: Equatable {
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    
    init() {
        
    }
    
    init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    var string: String {
        get {
            return "\(r.toIntScaledBy(255).clamped()) \(g.toIntScaledBy(255).clamped()) \(b.toIntScaledBy(255).clamped())"
        }
    }
    
    var cg: CGColor {
        get {
            return CGColor(red: r, green: g, blue: b, alpha: 1.0)
        }
    }
    
    static func == (lhs: Colour, rhs: Colour) -> Bool {
        return abs(lhs.r - rhs.r) < Config.epsilon &&
            abs(lhs.r - rhs.r) < Config.epsilon &&
            abs(lhs.r - rhs.r) < Config.epsilon
    }
    
    static let white = Colour(1,1,1)
    static let black = Colour(0,0,0)
}

func + (left: Colour, right: Colour) -> Colour {
    return Colour(left.r + right.r, left.g + right.g, left.b + right.b)
}

func - (left: Colour, right: Colour) -> Colour {
    return Colour(left.r - right.r, left.g - right.g, left.b - right.b)
}

func * (left: Colour, right: Colour) -> Colour {
    return Colour(left.r * right.r, left.g * right.g, left.b * right.b)
}

func * (left: Colour, right: CGFloat) -> Colour {
    return Colour(left.r * right, left.g * right, left.b * right)
}
