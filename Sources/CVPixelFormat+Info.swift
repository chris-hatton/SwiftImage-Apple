//
//  CVPixelFormat+Info.swift
//  SwiftImage-iOS
//
//  Created by Christopher Hatton on 18/03/2017.
//  Copyright © 2017 chris-hatton. All rights reserved.
//

import Foundation
import CoreVideo

typealias CVPixelFormat     = OSType
typealias CVPixelFormatInfo = (Int)

extension CVPixelFormat
{
	internal var info : CVPixelFormatInfo
	{

		switch self
		{
			case kCVPixelFormatType_1Monochrome   				: return (bitsPerPixel:  1 ) /* 1 bit indexed */
			case kCVPixelFormatType_2Indexed					: return (bitsPerPixel:  2 ) /* 2 bit indexed */
			case kCVPixelFormatType_4Indexed					: return (bitsPerPixel:  4 ) /* 4 bit indexed */
			case kCVPixelFormatType_8Indexed					: return (bitsPerPixel:  8 ) /* 8 bit indexed */
			case kCVPixelFormatType_1IndexedGray_WhiteIsZero	: return (bitsPerPixel:  1 ) /* 1 bit indexed gray, white is zero */
			case kCVPixelFormatType_2IndexedGray_WhiteIsZero	: return (bitsPerPixel:  2 ) /* 2 bit indexed gray, white is zero */
			case kCVPixelFormatType_4IndexedGray_WhiteIsZero	: return (bitsPerPixel:  4 ) /* 4 bit indexed gray, white is zero */
			case kCVPixelFormatType_8IndexedGray_WhiteIsZero	: return (bitsPerPixel:  8 ) /* 8 bit indexed gray, white is zero */
			case kCVPixelFormatType_16BE555						: return (bitsPerPixel: 16 ) /* 16 bit BE RGB 555 */
			case kCVPixelFormatType_16LE555						: return (bitsPerPixel: 16 ) /* 16 bit LE RGB 555 */
			case kCVPixelFormatType_16LE5551					: return (bitsPerPixel: 16 ) /* 16 bit LE RGB 5551 */
			case kCVPixelFormatType_16BE565						: return (bitsPerPixel: 16 ) /* 16 bit BE RGB 565 */
			case kCVPixelFormatType_16LE565						: return (bitsPerPixel: 16 ) /* 16 bit LE RGB 565 */
			case kCVPixelFormatType_24RGB						: return (bitsPerPixel: 24 ) /* 24 bit RGB */
			case kCVPixelFormatType_24BGR						: return (bitsPerPixel: 24 ) /* 24 bit BGR */
			case kCVPixelFormatType_32ARGB						: return (bitsPerPixel: 32 ) /* 32 bit ARGB */
			case kCVPixelFormatType_32BGRA						: return (bitsPerPixel: 32 ) /* 32 bit BGRA */
			case kCVPixelFormatType_32ABGR						: return (bitsPerPixel: 32 ) /* 32 bit ABGR */
			case kCVPixelFormatType_32RGBA						: return (bitsPerPixel: 32 ) /* 32 bit RGBA */
			case kCVPixelFormatType_64ARGB						: return (bitsPerPixel: 64 ) /* 64 bit ARGB, 16-bit big-endian samples */
			case kCVPixelFormatType_48RGB						: return (bitsPerPixel: 48 ) /* 48 bit RGB, 16-bit big-endian samples */
			case kCVPixelFormatType_32AlphaGray					: return (bitsPerPixel: 32 ) /* 32 bit AlphaGray, 16-bit big-endian samples, black is zero */
			case kCVPixelFormatType_16Gray						: return (bitsPerPixel: 16 ) /* 16 bit Grayscale, 16-bit big-endian samples, black is zero */
			case kCVPixelFormatType_30RGB						: return (bitsPerPixel: 32 ) /* 30 bit RGB, 10-bit big-endian samples, 2 unused padding bits (at least significant end). */
			case kCVPixelFormatType_422YpCbCr8					: return (bitsPerPixel: 0) /* Component Y'CbCr 8-bit 4:2:2, ordered Cb Y'0 Cr Y'1 */
			case kCVPixelFormatType_4444YpCbCrA8				: return (bitsPerPixel: 0) /* Component Y'CbCrA 8-bit 4:4:4:4, ordered Cb Y' Cr A */
			case kCVPixelFormatType_4444YpCbCrA8R				: return (bitsPerPixel: 0) /* Component Y'CbCrA 8-bit 4:4:4:4, rendering format. full range alpha, zero biased YUV, ordered A Y' Cb Cr */
			case kCVPixelFormatType_4444AYpCbCr8				: return (bitsPerPixel: 0) /* Component Y'CbCrA 8-bit 4:4:4:4, ordered A Y' Cb Cr, full range alpha, video range Y'CbCr. */
			case kCVPixelFormatType_4444AYpCbCr16				: return (bitsPerPixel: 0) /* Component Y'CbCrA 16-bit 4:4:4:4, ordered A Y' Cb Cr, full range alpha, video range Y'CbCr, 16-bit little-endian samples. */
			case kCVPixelFormatType_444YpCbCr8					: return (bitsPerPixel: 0) /* Component Y'CbCr 8-bit 4:4:4 */
			case kCVPixelFormatType_422YpCbCr16					: return (bitsPerPixel: 0) /* Component Y'CbCr 10,12,14,16-bit 4:2:2 */
			case kCVPixelFormatType_422YpCbCr10					: return (bitsPerPixel: 0) /* Component Y'CbCr 10-bit 4:2:2 */
			case kCVPixelFormatType_444YpCbCr10					: return (bitsPerPixel: 0) /* Component Y'CbCr 10-bit 4:4:4 */
			case kCVPixelFormatType_420YpCbCr8Planar			: return (bitsPerPixel: 0) /* Planar Component Y'CbCr 8-bit 4:2:0.  baseAddr points to a big-endian CVPlanarPixelBufferInfo_YCbCrPlanar struct */
			case kCVPixelFormatType_420YpCbCr8PlanarFullRange	: return (bitsPerPixel: 0) /* Planar Component Y'CbCr 8-bit 4:2:0, full range.  baseAddr points to a big-endian CVPlanarPixelBufferInfo_YCbCrPlanar struct */
			case kCVPixelFormatType_422YpCbCr_4A_8BiPlanar		: return (bitsPerPixel: 0) /* First plane: Video-range Component Y'CbCr 8-bit 4:2:2, ordered Cb Y'0 Cr Y'1; second plane: alpha 8-bit 0-255 */
			case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange: return (bitsPerPixel: 0) /* Bi-Planar Component Y'CbCr 8-bit 4:2:0, video-range (luma=[16,235] chroma=[16,240]).  baseAddr points to a big-endian CVPlanarPixelBufferInfo_YCbCrBiPlanar struct */
			case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange	: return (bitsPerPixel: 0) /* Bi-Planar Component Y'CbCr 8-bit 4:2:0, full-range (luma=[0,255] chroma=[1,255]).  baseAddr points to a big-endian CVPlanarPixelBufferInfo_YCbCrBiPlanar struct */
			case kCVPixelFormatType_422YpCbCr8_yuvs				: return (bitsPerPixel: 0) /* Component Y'CbCr 8-bit 4:2:2, ordered Y'0 Cb Y'1 Cr */
			case kCVPixelFormatType_422YpCbCr8FullRange			: return (bitsPerPixel: 0) /* Component Y'CbCr 8-bit 4:2:2, full range, ordered Y'0 Cb Y'1 Cr */
			case kCVPixelFormatType_OneComponent8				: return (bitsPerPixel: 0) /* 8 bit one component, black is zero */
			case kCVPixelFormatType_TwoComponent8				: return (bitsPerPixel: 0) /* 8 bit two component, black is zero */
			case kCVPixelFormatType_30RGBLEPackedWideGamut		: return (bitsPerPixel: 0) /* little-endian RGB101010, 2 MSB are zero, wide-gamut (384-895) */
			case kCVPixelFormatType_OneComponent16Half			: return (bitsPerPixel: 0) /* 16 bit one component IEEE half-precision float, 16-bit little-endian samples */
			case kCVPixelFormatType_OneComponent32Float			: return (bitsPerPixel: 0) /* 32 bit one component IEEE float, 32-bit little-endian samples */
			case kCVPixelFormatType_TwoComponent16Half			: return (bitsPerPixel: 0) /* 16 bit two component IEEE half-precision float, 16-bit little-endian samples */
			case kCVPixelFormatType_TwoComponent32Float			: return (bitsPerPixel: 0) /* 32 bit two component IEEE float, 32-bit little-endian samples */
			case kCVPixelFormatType_64RGBAHalf					: return (bitsPerPixel: 0) /* 64 bit RGBA IEEE half-precision float, 16-bit little-endian samples */
			case kCVPixelFormatType_128RGBAFloat				: return (bitsPerPixel: 0) /* 128 bit RGBA IEEE float, 32-bit little-endian samples */
			case kCVPixelFormatType_14Bayer_GRBG				: return (bitsPerPixel: 0) /* Bayer 14-bit Little-Endian, packed in 16-bits, ordered G R G R... alternating with B G B G... */
			case kCVPixelFormatType_14Bayer_RGGB				: return (bitsPerPixel: 0) /* Bayer 14-bit Little-Endian, packed in 16-bits, ordered R G R G... alternating with G B G B... */
			case kCVPixelFormatType_14Bayer_BGGR				: return (bitsPerPixel: 0) /* Bayer 14-bit Little-Endian, packed in 16-bits, ordered B G B G... alternating with G R G R... */
			case kCVPixelFormatType_14Bayer_GBRG				: return (bitsPerPixel: 0) /* Bayer 14-bit Little-Endian, packed in 16-bits, ordered G B G B... alternating with R G R G... */

			default: fatalError()
		}
	}
}
