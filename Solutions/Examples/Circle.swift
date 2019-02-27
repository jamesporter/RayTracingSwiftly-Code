import Cocoa
import CoreGraphics

func circleExample(canvasSize: Int) -> NSImage {
    var c = Canvas(w: canvasSize, h: canvasSize)

    let sphere = Sphere()
    let origin = Vector4.point(0, 0, -5)
    let wallZ: CGFloat = 10
    let wallSize = 7
    let halfWallSize = wallSize.f/2
    
    let pixelSize = wallSize.f / canvasSize.f
    
    let hitColour = Colour(0.0,0.8,0.0)
    var hCount = 0
    
    for i in 0..<c.w {
        for j in 0..<c.h {
            let wallX = i.f * pixelSize - halfWallSize
            let wallY = j.f * pixelSize - halfWallSize
            
            let r = Ray(at: origin, inDirection: (Vector4.point(wallX, wallY, wallZ)).normalised())
            
            if let _ = r.hit(object: sphere) {
                c[i,j] = hitColour
                hCount += 1
            }
        }
    }
    
    print("Hits: \(hCount)")
    
    let colorSpace = CGColorSpace(name: CGColorSpace.displayP3)!
    let context = CGContext(data: nil, width: canvasSize, height: canvasSize, bitsPerComponent: 8, bytesPerRow: 4 * c.w, space: colorSpace , bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    
    for i in 0..<c.w {
        for j in 0..<c.h {
            let col = c[i,j]
            context.setFillColor(col.cg)
            context.fill(CGRect(x: i, y: j, width: 1, height: 1))
        }
    }
    
    return NSImage(cgImage: context.makeImage()!, size: NSSize(width: c.w, height: c.h))
}
