//
//  Color.swift
//  Stitchdemo
//
//  Created by vizhi on 16/07/23.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class var lightColor : UIColor{
        return  UIColor(named: "lightColor") ?? UIColor.white
    }
    
    public class var blueColor : UIColor{
        return  UIColor(named: "blueColor") ?? UIColor.white
    }
    
    public class var darkblueColor : UIColor{
        return  UIColor(named: "darkBlueColor") ?? UIColor.white
    }
    
    public class var lightGrayColor : UIColor{
        return  UIColor(named: "lightGrayColor") ?? UIColor.lightGray
    }
    
    public class var violetColor : UIColor{
        return  UIColor(named: "voilet") ?? UIColor.purple.withAlphaComponent(0.5)
    }
    
    public class var redColor : UIColor{
        return  UIColor(named: "redColor") ?? UIColor.red.withAlphaComponent(0.5)
    }
    
    public class var borderGrayColor : UIColor{
        return  UIColor(named: "borderGrayColor") ?? UIColor.lightGray
    }
    
}
// MARK: - Initializers
public extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat) {
        let r = CGFloat((hex & 0xFF0000) >> 16)/255
        let g = CGFloat((hex & 0xFF00) >> 8)/255
        let b = CGFloat(hex & 0xFF)/255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        
        let hexString: String       = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner                 = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.currentIndex = hexString.startIndex
        }
        var color: UInt64 = 0
        scanner.scanInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    /// Create UIColor from RGB values with optional transparency.
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - transparency: optional transparency value (default is 1)
    convenience init(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        var trans: CGFloat {
            if transparency > 1 {
                return 1
            } else if transparency < 0 {
                return 0
            } else {
                return transparency
            }
        }
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
}

