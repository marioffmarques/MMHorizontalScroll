//
//  HorizontalScrollProtocol.swift
//  iosUtilComponents
//
//  Created by Mário Filipe Farate Marques on 03/05/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

import UIKit

protocol HorizontalScrollDelegate{
    
    func HorizontalScrollDidSelectElement(scroll: UIScrollView, selectedView: UIView?, elementAtIndex: Int?)
    func HorizontalScrollDidSelectAddButton(scroll: UIScrollView, selectedView: UIView?)
    
}