import Cocoa

struct Camera {
    let h: Int
    let w: Int
    
    let hSize: CGFloat
    let vSize: CGFloat
    let fov: CGFloat
    
    var transform: Matrix {
        didSet {
            inverseTransform = transform.inverted()
        }
    }
    private var inverseTransform: Matrix = Matrix.eye(4)
    
    let pixelSize: CGFloat
    
    let halfWidth: CGFloat
    let halfHeight: CGFloat
    
    
    init(w: Int, h: Int, fov: CGFloat) {
        self.w = w
        self.h = h
        
        // annoying naming book wanted h/v for horizontal/vertical
        self.hSize = CGFloat(w)
        self.vSize = CGFloat(h)
        self.fov = fov
        
        let halfView = tan(fov/2)
        let aspect = hSize / vSize
        
        if aspect >= 1 {
            halfWidth = halfView
            halfHeight = halfView / aspect
        } else {
            halfWidth = halfView * aspect
            halfHeight = halfView
        }
        
        pixelSize = halfWidth * 2 / hSize
        
        transform = Matrix.eye(4)
    }
    
    /*
     Get rays
     */
    subscript(x: Int, y: Int) -> Ray {
        get {
            let xOffset = (x.f + 0.5) * pixelSize
            let yOffset = (y.f + 0.5) * pixelSize
            
            let worldX = halfWidth - xOffset
            let worldY = halfHeight - yOffset
            
            let pixel = inverseTransform * Vector4.point(worldX, worldY, -1)
            let origin = inverseTransform * Vector4.point(0,0,0)
            let direction = (pixel - origin).normalised()
            
            return Ray(at: origin, inDirection: direction)
        }
    }
}
