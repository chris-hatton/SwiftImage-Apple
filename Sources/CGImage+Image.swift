//
//  CGImage+ImmutableImage.swift
//  ResistAR
//
//  Created by Christopher Hatton on 18/07/2015.
//  Copyright © 2015 AppDelegate. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftImage

extension CGImage : Image
{
    public typealias PixelColor       = RGBColor
    public typealias PixelColorSource = () -> PixelColor?
    
    public func read( region: ImageRegion ) -> PixelColorSource
    {
        guard let ephemeralRawData : CFData = self.dataProvider?.data else { fatalError() }
       
        let rawData = CFDataCreateCopy(nil, ephemeralRawData)  // The data provider & it's data are ephemeral, capture the data

        guard let pixelBytePtr : UnsafePointer<UInt8> = CFDataGetBytePtr( rawData ) else { fatalError() }
        
        return pixelBytePtr.withMemoryRebound( to: RGBColor.self, capacity: region.pixelCount )
        {
            pixelPtr in
            
            var mutablePixelPtr = UnsafeMutablePointer<RGBColor>(mutating: pixelPtr)
            
            let offset = ( Int( region.y ) * width ) + Int( region.x )
            mutablePixelPtr = mutablePixelPtr.advanced( by: offset )
            
            let widthOutsideRegion = Int( self.width - region.width )
            
            let nextLine : ()->Void = { mutablePixelPtr = mutablePixelPtr.advanced( by: widthOutsideRegion ) }
            
            let nextPixel : ()->PixelColor =
            {
                let pixel = mutablePixelPtr.pointee
                mutablePixelPtr = mutablePixelPtr.successor()
                return pixel
            }
            
            return regionRasterSource( region, nextPixel: nextPixel, nextLine: nextLine )
        }
    }
}
