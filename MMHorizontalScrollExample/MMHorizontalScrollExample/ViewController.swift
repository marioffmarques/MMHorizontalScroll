//
//  ViewController.swift
//  MMHorizontalScrollExample
//
//  Created by Mário Filipe Farate Marques on 29/08/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HorizontalScrollDelegate {

    
    @IBOutlet weak var mmHorizontalScroll: HorizontalScroll!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mmHorizontalScroll.delegate = self
        
        mmHorizontalScroll.setUpScrollWithImagesPath(
            ["images.jpeg", "image1.jpg", "image2.jpg"],
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

