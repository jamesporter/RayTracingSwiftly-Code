import Cocoa

struct Light {
    var intensity: Colour = Colour(1,1,1)
    var position = Vector4.point(0, 0, 0)
    
    init() {}
    
    init(position: Vector4, intensity: Colour) {
        self.position = position
        self.intensity = intensity
    }
}

enum LightCalculations {
    static func lighting(material: Material, light: Light, position: Vector4, eye: Vector4, normal: Vector4, inShadow: Bool) -> Colour {
        
        let effectiveColour = material.colour * light.intensity
        let lightV = (light.position - position).normalised()
        let ambient = effectiveColour * material.ambient
        
        if inShadow {
            return ambient
        }
        
        let diffuse: Colour
        let specular: Colour
        
        let lightDotNormal = lightV.dot(normal)
        if lightDotNormal < Config.epsilon {
            diffuse = Colour()
            specular = Colour()
        } else {
            diffuse = effectiveColour * material.diffuse * lightDotNormal
            let reflect = lightV.scaledBy(-1).reflect(in: normal)
            let reflectDotEye = reflect.dot(eye)
            
            if reflectDotEye <= Config.epsilon {
                specular = Colour()
            } else {
                let factor = pow(reflectDotEye, material.shininess)
                specular = light.intensity * material.specular * factor
            }   
        }
        return ambient + diffuse + specular
    }
    
    static func shade(in world: World, at comps: IntersectionComp, remaining: Int) -> Colour {
        let inShadow = LightCalculations.isInShadow(comps.overPoint, world: world)
        let refColour = reflectedColourFor(comps, in: world, remaining: remaining)
        let surface = lighting(material: comps.object.material, light: world.light!, position: comps.point, eye: comps.eye, normal: comps.normal, inShadow: inShadow)
        return surface + refColour
    }
    
    static func colourFor(ray: Ray, in world: World, remaining: Int) -> Colour {
        if let h = ray.hitFor(world: world) {
            let c = ray.intersectionComp(for: h)
            return shade(in: world, at: c, remaining: remaining)
        } else {
            return Colour.black
        }
    }
    
    static func reflectedColourFor(_ comps: IntersectionComp, in world: World, remaining: Int) -> Colour {
        if remaining <= 0 || comps.object.material.reflective < Config.epsilon {
            return Colour.black
        }
        
        let reflectRay = Ray(at: comps.overPoint, inDirection: comps.reflection)
        let colour = LightCalculations.colourFor(ray: reflectRay, in: world, remaining: remaining - 1)
        
        return colour * comps.object.material.reflective
    }
    
    static func isInShadow(_ point: Vector4, world: World ) -> Bool {
        let v = world.light!.position - point
        let distance = v.magnitude()
        let dir = v.normalised()
        
        let r = Ray(at: point, inDirection: dir)
        if let h = r.hitFor(world: world) {
            if h.time < distance {
                return true
            }
        }
        return false
    }
}
