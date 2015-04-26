//
//  UiColorExtension.swift
//  SteamLineiPhone
//
//  Created by Kyler Stole on 12/22/14.
//  Copyright (c) 2014 Kyler Stole. All rights reserved.
//

import UIKit

extension UIColor {
    /**
    Returns a color object whose RGB values are 243, 115, and 33 and whose alpha value is 1.0.
    
    This is OSU's official orange color.
    
    :returns: The UIColor object.
    */
    class func OSUOrangeColor() -> UIColor {
        return UIColor(red: 243/255.0, green: 115/255.0, blue: 33/255.0, alpha: 1.0)
    }
    
    class func OSUBlueColor() -> UIColor {
        return UIColor(red:0.27, green:0.48, blue:1, alpha:1)
    }
    /**
    Returns a color object whose RGB values are 104, 80, and 64 and whose alpha value is 1.0.
    
    This is OSU's official brown color.
    
    :returns: The UIColor object.
    */
    class func OSUBrownColor() -> UIColor {
        return UIColor(red: 104/255.0, green: 80/255.0, blue: 64/255.0, alpha: 1.0)
    }
    /**
    Returns a color object whose RGB values are 176, 96, and 16 and whose alpha value is 1.0.
    
    This is OSU's official neutral orange color.
    
    :returns: The UIColor object.
    */
    class func OSUNeutralOrangeColor() -> UIColor {
        return UIColor(red: 176/255.0, green: 96/255.0, blue: 16/255.0, alpha: 1.0)
    }
    
	/**
	Returns a color object whose RGB values are 111, 78, and 55 and whose alpha value is 1.0.
	
	This uses the official color coordinates 'coffee' color.
	
	:returns: The UIColor object.
	*/
	class func coffeeColor() -> UIColor {
		return UIColor(red: 111/255.0, green: 78/255.0, blue: 55/255.0, alpha: 1.0)
	}
	/**
	Returns a color object whose RGB values are 109, 43, and 0 and whose alpha value is 1.0.
	This
	
	This is coffee color with 100% saturation.
	
	:returns: The UIColor object.
	*/
	class func coffeeDeepColor() -> UIColor {
		return UIColor(red: 109/255.0, green: 43/255.0, blue: 0/255.0, alpha: 1.0)
	}
	/**
	Returns a color object whose RGB values are 109, 93, and 82 and whose alpha value is 1.0.
	
	This is coffee color with 25% saturation.
	
	:returns: The UIColor object.
	*/
	class func grayCoffeeColor() -> UIColor {
		return UIColor(red: 109/255.0, green: 93/255.0, blue: 82/255.0, alpha: 1.0)
	}
	/**
	Returns a color object whose RGB values are 53, 21, and 0 and whose alpha value is 1.0.
	
	This is coffee color with 100% saturation and 21% brightness.
	
	:returns: The UIColor object.
	*/
	class func darkCoffeeColor() -> UIColor {
		return UIColor(red: 53/255.0, green: 21/255.0, blue: 0/255.0, alpha: 1.0)
	}
	/**
	Returns a color object whose RGB values are 255, 215, and 100 and whose alpha value is 1.0.
	
	This uses the official color coordinates for the color gold.
	
	:returns: The UIColor object.
	*/
	class func goldColor() -> UIColor {
		return UIColor(red: 255/255.0, green: 215/255.0, blue: 100/255.0, alpha: 1.0)
	}
}