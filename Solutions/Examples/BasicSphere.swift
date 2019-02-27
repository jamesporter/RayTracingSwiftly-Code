import Cocoa
import CoreGraphics

func basicSphereExample(canvasSize: Int) -> NSImage {
    var c = Canvas(w: canvasSize, h: canvasSize)
    
    var sphere = Sphere()
    sphere.material.colour = Colour(0.1, 0.8, 0.1)
    //sphere.transformation = Transformation.scale(x: 1.2, y: 0.8, z: 0.4).rotatedY(CGFloat.pi/4)
    
    let light = Light(position: Vector4.point(-10, 10, -10), intensity: Colour(1,1,1))
    
    let origin = Vector4.point(0, 0, -5)
    let wallZ: CGFloat = 10
    let wallSize = 7
    let halfWallSize = wallSize.f/2
    
    let pixelSize = wallSize.f / canvasSize.f    
    for i in 0..<c.w {
        for j in 0..<c.h {
            let wallX = i.f * pixelSize - halfWallSize
            let wallY = j.f * pixelSize - halfWallSize
            
            let r = Ray(at: origin, inDirection: (Vector4.point(wallX, wallY, wallZ)).normalised())
            
            if let h = r.hit(object: sphere) {
                let n = sphere.normalAt(point: h.at)
                let eye = r.direction.scaledBy(-1)
                let colour = LightCalculations.lighting(material: sphere.material, light: light, position: h.at, eye: eye, normal: n, inShadow: false)
                c[i,j] = colour
            }
        }
    }
    
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
