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
    
    public class var lightGrayColor : UIColor{
        return  UIColor(named: "lightGrayColor") ?? UIColor.lightGray
    }
    
    public class var violetColor : UIColor{
        return  UIColor(named: "voilet") ?? UIColor.purple.withAlphaComponent(0.5)
    }
    
    public class var redColor : UIColor{
        return  UIColor(named: "redColor") ?? UIColor.red.withAlphaComponent(0.5)
    }
}

