# RayTracingSwiftly-Code

Unit Tests and sample solutions code for [The Ray Tracer Challenge](https://pragprog.com/book/jbtracer/the-ray-tracer-challenge)

I gave up at the refraction bit as I found it was getting a bit tedious! (In part because I had to write out these tests which you can just copy).

I did some basic optimisation/caching of transforms which *massively* improvded performance.

```swift
    var transformation = Matrix.eye(4) {
        didSet {
            invertedTransformation = transformation.inverted()
            invertedTransformationTranspose = invertedTransformation.transposed()
        }
    }
```

You might want to leave that out to keep code nicer (but speed up is ridiculous).

I include output as `NSImage` which is for Mac use in place of text based output.

I did get up to reflections and shadows. i.e. did get as far as:

- [x] Tuples, Points, and Vectors
- [x] Drawing on a Canvas
- [x] Matrices
- [x] Matrix Transformations
- [x] Ray-Sphere Intersections
- [x] Putting It Together
- [x] Light and Shading
- [x] Reflecting
- [x] Shadows
- [x] Planes
- [x] Patterns
- [x] Reflection

The solutions probably shouldn't be used directly but can be consulted.

I also included a View Controller for very basic MacApp that can run things/show results. You'll need to create your own UI etc if you want to use this.
