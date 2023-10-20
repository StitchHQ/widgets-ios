//
//  Fonts.swift
//  GoJekProvider
//
//  Created by apple on 05/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

//Custom font type
enum FontType: String {
    
    case bold = "EuclidFlex-Bold"
    case medium = "EuclidFlex-Medium"
    case regular = "EuclidFlex-Regular"
    case semiBold = "EuclidFlex-SemiBold"
    case sanSerif = "SansSerif-Medium"
    case ubuntu = "Ubuntu-Medium"
    case notoSans = "NotoSans-Medium"
    case monoSpace = "Monospace-Medium"
    case roboto = "Roboto-Medium"
    case serif = "Serif-Medium"
    case dancingScript = "DancingScript-Medium"

}

//Custom font size
//Text should be at least 11 points so it’s legible at a typical viewing distance without zooming.

enum FontSize: CGFloat {
    case x9 = 9.0
    case x12 = 12.0
    case x14 = 14.0
    case x16 = 16.0
    case x18 = 18.0
    case x20 = 20.0
    case x22 = 22.0
    case x24 = 24.0
    case x26 = 26.0
    case x28 = 28.0
    case x30 = 30.0
    case x50 = 50.0
}

//Set Custom font and size
extension UIFont {
    
    class func setCustomFont(name: FontType, size: FontSize) -> UIFont {
        return UIFont(name: name.rawValue, size: size.rawValue) ?? UIFont.systemFont(ofSize: 16)
    }
}

