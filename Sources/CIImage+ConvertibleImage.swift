//
//  CIImage+ConvertibleImage.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 05/10/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation
import CoreImage
import SwiftImage
import UIKit

extension CIImage : ConvertibleImage
{
    @nonobjc public func convert() throws -> UIImage
    {
        return UIImage(ciImage: self)
    }
    
    @nonobjc public func convert() throws -> CGImage
    {
        guard let cgImage = self.cgImage else { throw ConvertibleImageError.ConversionFailure }
        return cgImage
    }
    
    @nonobjc public func convert() throws -> CVPixelBuffer
    {
        let cgImage = self.cgImage!
        return try cgImage.convert()
    }
    
    @nonobjc public func convert() throws -> GenericImage<RGBColor>
    {
        let cgImage = self.cgImage!
        return try cgImage.convert()
    }
}
