# MMHorizontalScroll
Swift Horizontal Scroll control that allows scrolling over a set of images on X axis. This control also provides a customizable title Header and Footer

## Setup

1. Copy files to ios project
2. Create a View and set the View Class to HorizontalScroll


## Example Use

    class ViewController: UIViewController, HorizontalScrollDelegate {

    
    @IBOutlet weak var scroll: HorizontalScroll!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.delegate = self
    }
    

    override func viewDidAppear(animated: Bool) {
        
        scroll.setUpScrollWithImagesPath(["images.jpeg", "image1.jpg", "image2.jpg"],
            imagesTitles: ["This is a large title that fits to container", "Titulo2", "Titulo3"],
            titleColor: UIColor.grayColor(),
            withAddButtonImage: nil)
    }


    func HorizontalScrollDidSelectAddButton(scroll: UIScrollView, selectedView: UIView?) {
        NSLog("Select add button")
    }

    func HorizontalScrollDidSelectElement(scroll: UIScrollView, selectedView: UIView?, elementAtIndex: Int?) {
        NSLog("Select Element")
    }
}


### Todo

1. Get images from a Url List
