import Cocoa

struct Ray {
    var origin: Vector4
    var direction: Vector4
    
    init(at org: Vector4, inDirection dir: Vector4) {
        origin = org
        direction = dir
    }
    
    func position(atTime t: CGFloat) -> Vector4 {
        return origin + direction * t
    }
        
    func hit(object: Shape) -> (time: CGFloat, at: Vector4)? {
        let inters = object.intersectionsOf(ray: self).filter { $0.time >= 0 }
        if inters.count == 0 {
            return nil
        } else {
            return inters.sorted { $0.time < $1.time }[0]
        }
    }
    
    func transformed(by matrix: Matrix) -> Ray {
        return Ray(at: matrix * origin, inDirection: matrix * direction)
    }
    
    func intersectionsIn(world: World) -> [(time: CGFloat, at: Vector4, object: Shape)] {
        let inters = world.objects.flatMap { s in
            s.intersectionsOf(ray: self).map { (time: $0.0, at: $0.1, object: s)}
        }
        return inters.sorted { $0.time < $1.time }
    }
    
    func hitFor(world: World) -> (time: CGFloat, at: Vector4, object: Shape)? {
        let posTInters = intersectionsIn(world: world).filter { $0.time > 0 }
        return posTInters.count > 0 ? posTInters[0] : nil
    }
    
    func intersectionComp(for inter: (time: CGFloat, at: Vector4, object: Shape)) -> IntersectionComp {
        var n = inter.object.normalAt(point: inter.at)
        var inside = false
        let eye = direction.scaledBy(-1)
        if n.dot(eye) < 0 {
            inside = true
            n = n.scaledBy(-1)
        }
        let overPoint = inter.at + n * Config.epsilon
        let reflection = direction.reflect(in: n)
        return IntersectionComp(object: inter.object, t: inter.time, eye: eye, point: inter.at, normal: n, reflection: reflection, inside: inside, overPoint: overPoint)
    }
}
