import Cocoa

struct Material {
    var colour = Colour(1,1,1)
    var ambient: CGFloat = 0.1
    var diffuse: CGFloat = 0.9
    var specular: CGFloat = 0.9
    var shininess: CGFloat = 200.0
    var reflective: CGFloat = 0.0
}
