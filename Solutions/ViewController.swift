import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var status: NSTextField!
    
    var outputImage: NSImage?
    
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var infoLabel: NSTextField!
    
    var detail = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.imageScaling = .scaleProportionallyUpOrDown
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func updateSlider(_ sender: NSSlider) {
        detail = Int(sender.floatValue)
        infoLabel.stringValue = "\(detail)"
    }
    
    @IBAction func start(_ sender: Any) {
        status.stringValue = "Running"
        startButton.isEnabled = false
        
        let concurrentQueue = DispatchQueue(label: "worker", attributes: .concurrent)
        concurrentQueue.async {
            //let img = circleExample(canvasSize: 100)
            //let img = basicSphereExample(canvasSize: 600)
            let img = basicBallsOnReflectivePlane(canvasSize: self.detail) { p in
                DispatchQueue.main.async {
                    self.status.stringValue = String(format: "%.2f%%", p * 100)
                }
            }
            DispatchQueue.main.async {
                self.status.stringValue = "Done"
                self.startButton.isEnabled = true
                self.imageView.image = img
                self.outputImage = img
            }
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if let img = outputImage {
            let savePanel = NSSavePanel()
            savePanel.canCreateDirectories = true
            savePanel.allowedFileTypes = ["png"]
            savePanel.isExtensionHidden = false
            savePanel.nameFieldStringValue = "raytraced.png"
            
            savePanel.begin { result in
                if result == .OK {
                    if let filename = savePanel.url {
                        do {
                            try img.pngData?.write(to: filename)
                        } catch {
                        // ha
                        }
                    }
                }
            }
        }
    }
}

extension NSImage {
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
}
