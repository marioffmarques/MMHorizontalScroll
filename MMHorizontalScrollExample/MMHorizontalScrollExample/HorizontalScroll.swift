//
//  HorizontalScroll.swift
//  iosUtilComponents
//
//  Created by Mário Filipe Farate Marques on 29/04/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

import UIKit

@IBDesignable class HorizontalScroll: UIView {

    var delegate: HorizontalScrollDelegate?
    
    var view: UIView!   // This is the view (parent) that will contains this element
    var nibName: String  = "HorizontalScroll"
    var scrollImages: [String] = []
    var scrollImagesUrl: [String] = []
    
    var _imageWidth: CGFloat?
    var _imageHeight: CGFloat?
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelFooter: UILabel!
    
    
    @IBInspectable var title: String? {
        get {
            return labelTitle.text
        }
        set(_title) {
            labelTitle.text = _title
        }
    }
    
    @IBInspectable var titleColor: UIColor? {
        get {
            return labelTitle.textColor
        }
        set(_color) {
            labelTitle.textColor = _color
        }
    }
    
    @IBInspectable var scrollBackgroundColor: UIColor? {
        get {
            return scrollView.backgroundColor
        }
        set(_color) {
            scrollView.backgroundColor = _color
        }
    }
    
    @IBInspectable var footer: String? {
        get {
            return labelFooter.text
        }
        set(_footer) {
            labelFooter.text = _footer
        }
    }
    
    @IBInspectable var footerColor: UIColor? {
        get {
            return labelFooter.textColor
        }
        set(_color) {
            labelFooter.textColor = _color
        }
    }

    @IBInspectable var imageWidth: CGFloat? {
        get {
            return _imageWidth
        }
        set(_iW) {
            _imageWidth = _iW
        }
    }
    
    @IBInspectable var imageHeight: CGFloat? {
        get {
            return _imageHeight
        }
        set(_iH) {
            _imageHeight = _iH
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Setup() // Setup when this component is used from Storyboard
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Setup() // Setup when this component is used from Code
    }
    
    func Setup(){
        view = LoadViewFromNib()
        
        addSubview(view)
        
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        scrollView.layer.cornerRadius = 5
    }
    
    func LoadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    

    
    func setUpScrollWithImagesPath(imagesPathArray: [String], imagesTitles: [String]?, titleColor: UIColor?, withAddButtonImage addButtonImage: String?){
        
        if( imagesPathArray.count <= 0){
            return
        }
        
        if ( imagesTitles?.count < imagesPathArray.count ){
            NSLog("Error: ImagesTitles must be not nil and have the amount of element such as the imagesPathArray")
            return
        }
        
        if(imageWidth == nil) {
            imageWidth = self.scrollView.frame.width / 2.5
        }
        
        if(imageHeight == nil) {
            imageHeight = self.scrollView.frame.height - 20 //self.scrollView.frame.height - 10 //(view.frame.height - 5)
        }
        
        scrollImages = imagesPathArray
        
        for var i = 0 ; i < scrollImages.count; i++ {
            
            // Setup image Container View
            var imageContainerview = UIView()
            imageContainerview.alpha = 0
            
            imageContainerview.frame = CGRectMake(CGFloat(10 + i*Int(imageWidth! + 10) ), 10, imageWidth!, imageHeight! )
            imageContainerview.tag = i;
            imageContainerview.layer.cornerRadius = 5
            imageContainerview.clipsToBounds = true
            
            
            
            var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleImageTap:")
            imageContainerview.addGestureRecognizer(tapGesture)
            
            
            // Setup image
            var image: UIImage = UIImage(named: scrollImages[i])!
            var imageView = UIImageView(image: image)
            imageView.frame = CGRectMake(0,0,imageWidth!, imageHeight!)
            
            
            // Add Blur effect with name
            var blur: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            var effectView: UIVisualEffectView = UIVisualEffectView(effect: blur)
            effectView.frame = CGRectMake(0, imageHeight! - imageHeight! / 3.5 , imageWidth!, imageHeight! / 3.5)
            

            imageContainerview.addSubview(imageView)
            
            if imagesTitles != nil {
                var bottomTitle: UILabel = UILabel(frame: CGRectMake(0, 0, effectView.frame.width, effectView.frame.height))
                
                bottomTitle.textAlignment = NSTextAlignment.Center
                bottomTitle.numberOfLines = 2
                bottomTitle.adjustsFontSizeToFitWidth = true
                bottomTitle.text = imagesTitles![i]
                
                if titleColor != nil{
                    bottomTitle.textColor = titleColor!
                }
                
                effectView.addSubview(bottomTitle)
                imageContainerview.addSubview(effectView)
            }
            
            
            self.scrollView.addSubview(imageContainerview)

            
            UIView.animateWithDuration(0.5, delay: 0.2 * Double(i), options: nil, animations: {
                imageContainerview.alpha = 1
            }, completion: nil)
            
            self.scrollView.contentSize = CGSizeMake(CGFloat(Int(imageWidth!) * scrollImages.count + ((scrollImages.count + 1) * 10)), imageHeight!)
        }
        
        
        if(addButtonImage != nil) {
            
            var imageContainerview = UIView()
            imageContainerview.alpha = 0
            
            imageContainerview.frame = CGRectMake(CGFloat(10 + scrollImages.count*Int(imageWidth! + 10) ), 10, imageWidth!, imageHeight! ) // x, y, width, height
            imageContainerview.backgroundColor = UIColor.grayColor()
            imageContainerview.tag = scrollImages.count;
            
            
            var image: UIImage = UIImage(named: addButtonImage!)!
            var imageView = UIImageView(image: image)
            
            
            imageView.frame = CGRectMake(0,0,imageWidth!, imageHeight!)
            
            // Add Tap Recognizer to the Image
            var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleImageTap:")
            imageContainerview.addGestureRecognizer(tapGesture)
            
            imageContainerview.layer.cornerRadius = 5
            imageContainerview.clipsToBounds = true
            
            imageContainerview.addSubview(imageView)
            
            
            self.scrollView.addSubview(imageContainerview)
            
            
            UIView.animateWithDuration(0.5, delay: 0.2 * Double(scrollImages.count), options: nil, animations: {
                imageContainerview.alpha = 1
                }, completion: nil)
            
            
            self.scrollView.contentSize = CGSizeMake(CGFloat(Int(imageWidth!) * (scrollImages.count + 1) + ((scrollImages.count + 2) * 10)), imageHeight!)
        }
        
        
    }
    
    func setUpScrollWithImagesUrl(imagesPathArray: [String]) {
    
    }
    
    
    func setScrollWithBackgroundImageName(image: String!){
        
        self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: image)!)
    }
    
    func setScrollWithBackgroundColor(color: UIColor!){
        
        self.scrollView.backgroundColor = color
    }
    
    
    func handleImageTap(recognizer: UITapGestureRecognizer) {
        
        var tappedView: UIView? = recognizer.view
    
        if tappedView?.tag == scrollImages.count {
            delegate?.HorizontalScrollDidSelectAddButton(scrollView, selectedView: tappedView as? UIImageView)
        }
        else{
            delegate?.HorizontalScrollDidSelectElement(scrollView, selectedView: tappedView as? UIImageView, elementAtIndex: tappedView?.tag)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}
