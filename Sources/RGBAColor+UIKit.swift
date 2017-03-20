//
//  RGBColor+UIKit.swift
//  SwiftImage-iOS
//
//  Created by Christopher Hatton on 16/03/2017.
//  Copyright © 2017 chris-hatton. All rights reserved.
//

import Foundation
import SwiftImage
import UIKit

public extension RGBAColor
{
    public init(_ color: UIColor)
    {
        var red     : CGFloat = 0.0
        var green   : CGFloat = 0.0
        var blue    : CGFloat = 0.0
        var alpha   : CGFloat = 0.0
        
        color.getRed( &red, green: &green, blue: &blue, alpha: &alpha)
        
        self.init( Double(red), Double(green), Double(blue), Double(alpha) )
    }
}
