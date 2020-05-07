//
//  NSUIColor+HexValue.swift
//  Covid-19App
//
//  Created by iosdev on 7.5.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//
//  Class extens UIColor to provide hex values for colors used in the application

import Foundation
import Charts

extension NSUIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "invalid component")
        assert(green >= 0 && green <= 255, "invalid component")
        assert(blue >= 0 && blue <= 255, "invalid component")
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }

// bits shifting to provide hex values
    convenience init(hex: Int) {
        self.init (
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex  & 0xFF
        )
    }
    
}
