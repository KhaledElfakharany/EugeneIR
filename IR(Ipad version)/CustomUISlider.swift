//
//  CustomSlider.swift
//  IR
//
//  Created by Khaled Elfakharany on 6/2/17.
//  Copyright © 2017 Khaled Elfakharany. All rights reserved.
//

import Foundation
import UIKit

class CustomUISlider : UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 15.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
}
