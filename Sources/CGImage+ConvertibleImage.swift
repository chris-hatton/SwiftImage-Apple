//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftImage
import UIKit
import CoreVideo
import CoreImage

extension CGImage
{
    public func convert() throws -> UIImage
    {
        return UIImage(cgImage: self)
    }
    
    public func convert() throws -> GenericImage<RGBColor>
    {
        let fillColor = RGBColor(0,0,0)
        let image = GenericImage<RGBColor>(width: self.width, height: self.height, fill: fillColor)
        
        // Check if the image is already in native format and do byte copy if possible
        
        let isNativeFormat : Bool = true
        
        if isNativeFormat
        {
            let cfData    : CFData               = (self.dataProvider?.data)!
            let srcPtr    : UnsafePointer<UInt8> = CFDataGetBytePtr(cfData)
            let srcRawPtr : UnsafeRawPointer     = UnsafeRawPointer(srcPtr)
            
            let _ = image.pixels.withUnsafeMutableBufferPointer
            {
                destinationBufferPtr in
                
                let destinationRawPtr = destinationBufferPtr.baseAddress!
            
                memcpy(destinationRawPtr, srcRawPtr, MemoryLayout<RGBColor>.size * width * height)
            }
            
            let region = ImageRegion( image: self )
            
            let regionPixelColorSource: PixelColorSource = self.read( region: region )
            
            image.write( region: region, pixelColorSource: regionPixelColorSource)
        }
        else  // Non-native format; perform a lengthier draw & copy.
        {
            fatalError( "Not yet implemented" )
        }

        return image
    }
    
    public func convert() throws -> CVPixelBuffer
    {
        let width  : Int = Int( self.width  )
        let height : Int = Int( self.height )
        
        let frameSize : CGSize = CGSize( width: width, height: height )
        
        let options : [ String : Bool ] = [
            kCVPixelBufferCGImageCompatibilityKey         as String : false,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String : false
        ]
        
        var bufferRef : CVPixelBuffer? = nil
        
        let status : CVReturn = CVPixelBufferCreate(
            kCFAllocatorDefault,
            Int(frameSize.width),
            Int(frameSize.height),
            kCVPixelFormatType_32RGBA,
            options as CFDictionary,
            &bufferRef
        )
        
        assert(status == kCVReturnSuccess)
        
        guard let buffer = ( status == kCVReturnSuccess ) ? ( bufferRef! ) : (nil as CVPixelBuffer?) else
        {
            fatalError()
        }
        
        let pixelData : UnsafeMutableRawPointer = CVPixelBufferGetBaseAddress( bufferRef! )!;
        
        let rgbColorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context : CGContext = CGContext(
            data: pixelData,
            width: Int( frameSize.width ),
            height: Int( frameSize.height ),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow( buffer ),
            space: rgbColorSpace,
            bitmapInfo: UInt32(0) //TODO: Replace with kCGImageAlphaNoneSkipLast
            )!
        
        let rect : CGRect = CGRect(x: 0, y: 0, width: CGFloat( width ), height: CGFloat( height ) )
        
        context.draw( self, in: rect)
        
        CVPixelBufferUnlockBaseAddress( buffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)) )
        
        return buffer
    }
    
    public func convert() throws -> CIImage
    {
        return CIImage(cgImage: self)
    }
    
    /*
    private func getRGBPixelColorSource() -> PixelColorSource
    {
        let bytesPerPixel : Int = 4
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let rawData : UnsafeMutablePointer<UInt8> = calloc( width * height * bytesPerPixel, MemoryLayout<UInt8>.size).assumingMemoryBound(to: UInt8.self)
        
        let bytesPerRow      : Int = bytesPerPixel * width
        let bitsPerComponent : Int = 8
        let context          : CGContext = CGBitmapContextCreate(
            rawData,
            width,
            height,
            bitsPerComponent,
            bytesPerRow,
            colorSpace,
            kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
        )
        
        let drawRect = CGRect( x:0, y:0, width:CGFloat(width), height:CGFloat(height) )
        
        context.draw( self, in: drawRect)
        
        let source : PixelColorSource =
        {
            () -> RGBPixel? in
            
            if true
            {
                let isLast = false
                
                if isLast
                {
                    free(rawData)
                }
            }
            else
            {
                return nil
            }
        }
        
        return source
    }
 */
}
