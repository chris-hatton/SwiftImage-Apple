//
//  UIImage+GenericImageConvertible.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 02/08/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftImage

extension UIImage : ConvertibleImage
{
    @nonobjc public func convert() throws -> GenericImage<PixelColor>
    {
        return try self.cgImage!.convert()
    }
    
    @nonobjc public func convert() throws -> CGImage
    {
        return self.cgImage!
    }
    
    @nonobjc public func convert() throws -> CIImage
    {
        return self.ciImage!
    }
    
    @nonobjc public func convert() throws -> CVPixelBuffer
    {
        return try self.cgImage!.convert()
    }
}

extension UIImage
{
    
}
