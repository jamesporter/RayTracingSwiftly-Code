import Cocoa

struct Canvas {
    
    private var data: [Colour]
    let w: Int
    let h: Int
    
    init(w: Int, h: Int) {
        self.w = w
        self.h = h
        data = [Colour].init(repeating: Colour(), count: w * h)
    }
    
    subscript(x: Int, y: Int) -> Colour {
        get {
            return data[w * y + x]
        }
        
        set {
            data[w * y + x] = newValue
        }
    }
    
    var pixels: [Colour] {
        get {
            return data
        }
    }
    
    var ppm: String {
        get {
            var s = """
                    P3
                    \(w) \(h)
                    255
                    
                    """
            data.chunked(7).forEach {
                line in
                s.append(line.map { $0.string }.joined(separator: " "))
                s.append("\n")
            }
            return s
        }
    }
    
    var image: NSImage {
        get {
            let colorSpace = CGColorSpace(name: CGColorSpace.displayP3)!
            let context = CGContext(data: nil, width: w, height: h, bitsPerComponent: 8, bytesPerRow: 4 * w, space: colorSpace , bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
            
            for i in 0..<w {
                for j in 0..<h {
                    let col = self[i,j]
                    context.setFillColor(col.cg)
                    context.fill(CGRect(x: i, y: j, width: 1, height: 1))
                }
            }
            
            return NSImage(cgImage: context.makeImage()!, size: NSSize(width: w, height: h))
        }
    }
}
