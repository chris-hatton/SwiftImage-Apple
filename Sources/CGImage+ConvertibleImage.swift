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
    
    public func isRGBA() -> Bool
    {
        let rgbaComponentCount   = 4
        let rgbaBitsPerComponent = 8
        
        return self.bitsPerComponent == rgbaBitsPerComponent                        &&
               self.bitsPerPixel     == (rgbaBitsPerComponent * rgbaComponentCount)
    }
    
    public func convert() throws -> GenericImage<RGBColor>
    {
        let fillColor = RGBColor(0,0,0)
        let image = GenericImage<RGBColor>(width: self.width, height: self.height, fill: fillColor)
        
        // Check if the image is already in RGB format and do byte copy if possible
        
        if self.isRGBA()
        {
            guard let dataProvider = self.dataProvider else { fatalError("Can't get data provider!") }
            guard let data         = dataProvider.data else { fatalError("Can't get data!"         ) }
            
            let cfData    : CFData               = data
            let srcPtr    : UnsafePointer<UInt8> = CFDataGetBytePtr(cfData)
            let srcRawPtr : UnsafeRawPointer     = UnsafeRawPointer(srcPtr)
            
            _ = image.pixels.withUnsafeMutableBufferPointer
            {
                destinationBufferPtr in
                
                let destinationRawPtr = destinationBufferPtr.baseAddress!
            
                memcpy(destinationRawPtr, srcRawPtr, MemoryLayout<RGBColor>.size * width * height)
            }
        }
        else  // Non-RGBA format; perform a lengthier draw & copy.
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
            width,
            height,
            kCVPixelFormatType_32BGRA, //kCVPixelFormatType_32RGBA cases error
            options as CFDictionary,
            &bufferRef
        )
        
        guard status == kCVReturnSuccess else { fatalError( status.description ) }
        guard let buffer : CVPixelBuffer = bufferRef else { fatalError( "No buffer returned" ) }
        
        let lockFlags = CVPixelBufferLockFlags(rawValue: CVOptionFlags(0))
        
        CVPixelBufferLockBaseAddress( buffer, lockFlags )
        
        guard let pixelData : UnsafeMutableRawPointer = CVPixelBufferGetBaseAddress( buffer ) else { fatalError("Can't get buffer base address") }
        
        let rgbColorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let context : CGContext = CGContext(
            data             : pixelData,
            width            : width,
            height           : height,
            bitsPerComponent : self.bitsPerComponent,
            bytesPerRow      : self.bytesPerRow,
            space            : rgbColorSpace,
            bitmapInfo       : UInt32(0) //TODO: Replace with kCGImageAlphaNoneSkipLast
        )
        else { fatalError( "Can't create CGContext" ) }
        
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
     let region = ImageRegion( image: self )
     let regionPixelColorSource: PixelColorSource = self.read( region: region )
     image.write( region: region, pixelColorSource: regionPixelColorSource )
     */
    
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
