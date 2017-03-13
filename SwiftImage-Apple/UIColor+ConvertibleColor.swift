import UIKit
import SwiftImage

extension UIColor : ConvertibleColor
{
	public func convert<T:Color>() throws -> T
	{
		throw ColorConversionError.UnsupportedConversion(from: type(of:self), to: T.self as! AnyObject.Type)
	}
    
    public func convert() throws -> RGBColor
    {
        return RGBColor(self)
    }
}
