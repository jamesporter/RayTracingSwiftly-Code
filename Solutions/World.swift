import Cocoa

struct World {
    var light: Light?
    var objects: [Shape] = []
    var camera: Camera? = nil
    
    static func createDefault() -> World {
        var w = World()
        w.light = Light(position: Vector4.point(-10, 10, -10), intensity: Colour.white)
        
        var s1 = Sphere()
        s1.material = Material(colour: Colour(0.8, 1,0.6), ambient: 0.1, diffuse: 0.7, specular: 0.2, shininess: 200.0, reflective: 0.0)
        
        var s2 = Sphere()
        s2.transformation = Transformation.scale(x: 0.5, y: 0.5, z: 0.5)
        
        w.objects = [s1, s2]
        
        return w
    }
    
    func render(progress: ((CGFloat) -> Void)? = nil) -> Canvas? {
        guard let c = camera else {
            return nil
        }
        var canvas = Canvas(w: c.w, h: c.h)
        for y in 0..<c.h {
            progress?(y.f/c.h.f)
            for x in 0..<c.w {
                canvas[x,y] = LightCalculations.colourFor(ray: c[x,y] , in: self, remaining: Config.defaultRemaining)
            }
        }
        return canvas
    }
}

