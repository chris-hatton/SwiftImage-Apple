//
//  CoreVideoException.swift
//  SwiftImage-iOS
//
//  Created by Christopher Hatton on 18/03/2017.
//  Copyright © 2017 chris-hatton. All rights reserved.
//

import Foundation
import CoreVideo

extension CVReturn
{
    var description : String
    {
        switch self
        {
            case kCVReturnSuccess   : return "Success"
            
            case kCVReturnFirst             : return "First"
            case kCVReturnError             : return "Error"
            case kCVReturnInvalidArgument   : return "Invalid argument"
            case kCVReturnAllocationFailed  : return "Allocation failed"
            case kCVReturnUnsupported       : return "Unsupported"
            
            // DisplayLink related errors
            case kCVReturnInvalidDisplay            : return "Invalid display"
            case kCVReturnDisplayLinkAlreadyRunning : return "DisplayLink already running"
            case kCVReturnDisplayLinkNotRunning     : return "DisplayLink not running"
            case kCVReturnDisplayLinkCallbacksNotSet: return "DisplayLink callbacks not set"
            
            // Buffer related errors
            case kCVReturnInvalidPixelFormat            : return "Invalid pixel format"
            case kCVReturnInvalidSize                   : return "Invalid size"
            case kCVReturnInvalidPixelBufferAttributes  : return "Invalid PixelBuffer attributes"
            case kCVReturnPixelBufferNotOpenGLCompatible: return "Buffer not OpenGL compatible"
            case kCVReturnPixelBufferNotMetalCompatible : return "Buffer not metal compatible"
            
            // Buffer Pool related errors
            case kCVReturnWouldExceedAllocationThreshold    : return "Would exceed allocation threshold"
            case kCVReturnPoolAllocationFailed              : return "Pool allocation failed"
            case kCVReturnInvalidPoolAttributes             : return "Invalid pool attributes"
            case kCVReturnRetry                             : return "Retry"
            
            case kCVReturnLast  : return "Last"
            
            default : return "Unknown error \(self)"
        }
    }
}
