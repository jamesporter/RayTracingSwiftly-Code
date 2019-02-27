    import Cocoa
    import CoreGraphics
    
    func basicWorldRenderingExample(canvasSize: Int, progress: @escaping ((CGFloat) -> Void)) -> NSImage {
        var w = World.createDefault()
        
        var s1 = Sphere()
        s1.material = Material(colour: Colour(0.8, 0.2,0.2), ambient: 0.1, diffuse: 0.7, specular: 0.2, shininess: 200.0, reflective: 0.0)
        s1.transformation = Transformation.translate(x: 2, y: 0.5, z: 0.5)
        w.objects.append(s1)
        
        var s2 = Sphere()
        s2.material = Material(colour: Colour(0.8, 0.8,0.2), ambient: 0.1, diffuse: 0.7, specular: 0.2, shininess: 200.0, reflective: 0.0)
        s2.transformation = Transformation.translate(x: -2, y: -0.5, z: -0.5)
        w.objects.append(s2)
        
        var s3 = Sphere()
        s3.transformation = Transformation.translate(x: -3, y: 3, z: -3)
        w.objects.append(s3)
        
        var c = Camera(w: canvasSize, h: canvasSize, fov: CGFloat.pi/2)
        c.transform = ViewTransformations.viewTransform(from: Vector4.point(0,0,-5), to: Vector4.point(0,0,0), up: Vector4.vector(0,1,0))
        w.camera = c
        let canvas = w.render(progress: progress)!
        return canvas.image
    }
    
    func basicBallsOnPlane(canvasSize: Int, progress: @escaping ((CGFloat) -> Void)) -> NSImage {
        var w = World.createDefault()
        
        
        var floor = Plane()
        floor.transformation = Transformation.translate(x: 0, y: -2, z: 0)
        w.objects.append(floor)
        
        var wall = Plane()
        wall.transformation = Transformation.translate(x: 4, y: 0, z: 0) * Transformation.rotZ(CGFloat.pi/2)
        w.objects.append(wall)
        
        var s3 = Sphere()
        s3.transformation = Transformation.translate(x: 2, y: 0.5, z: 0)
        w.objects.append(s3)
        
        var c = Camera(w: canvasSize, h: canvasSize, fov: CGFloat.pi/2)
        c.transform = ViewTransformations.viewTransform(from: Vector4.point(2,2,-5), to: Vector4.point(0,0,0), up: Vector4.vector(0,1,0))
        w.camera = c
        let canvas = w.render(progress: progress)!
        return canvas.image
    }
    
    func basicBallsOnReflectivePlane(canvasSize: Int, progress: @escaping ((CGFloat) -> Void)) -> NSImage {
        var w = World.createDefault()
        
        
        var floor = Plane()
        floor.transformation = Transformation.translate(x: 0, y: -2, z: 0)
        floor.material.reflective = 0.8
        w.objects.append(floor)
        
        var wall = Plane()
        wall.transformation = Transformation.translate(x: 4, y: 0, z: 0) * Transformation.rotZ(CGFloat.pi/2)
        w.objects.append(wall)
        
        var s3 = Sphere()
        s3.transformation = Transformation.translate(x: 2, y: 0.5, z: 0)
        s3.material.reflective = 0.8
        w.objects.append(s3)
        
        
        var c = Camera(w: canvasSize, h: canvasSize, fov: CGFloat.pi/2)
        c.transform = ViewTransformations.viewTransform(from: Vector4.point(2,2,-5), to: Vector4.point(0,0,0), up: Vector4.vector(0,1,0))
        w.camera = c
        let canvas = w.render(progress: progress)!
        return canvas.image
    }

