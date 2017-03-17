//
//  !CVPixelBuffer+ConvertibleImage.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 5/09/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation
import SwiftImage

import CoreVideo
import CoreImage
import UIKit

extension CVPixelBuffer : ConvertibleImage
{
    public func convert() throws -> CGImage
    {
        let ciImage: CIImage = try self.convert()
        
        let temporaryContext : CIContext = CIContext()
        
        let rect : CGRect = CGRect( x: 0, y: 0, width: CGFloat( self.width ), height: CGFloat( self.height ) )
        
        return temporaryContext.createCGImage( ciImage, from: rect )!
    }
    
    public func convert() throws -> CIImage
    {
        return CIImage( cvPixelBuffer: self )
    }
    
    public func convert() throws -> UIImage
    {
        return UIImage( cgImage: try convert() as CGImage )
    }
    
    public func convert() throws -> GenericImage<RGBColor>
    {
        let cgImage : CGImage = try self.convert()
        return try cgImage.convert()
    }
}
