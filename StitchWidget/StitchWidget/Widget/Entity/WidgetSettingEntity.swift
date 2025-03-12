//
//  WidgetSettingEntity.swift
//  StitchDemo
//
//  Created by vizhi on 04/03/25.
//

import Foundation
import UIKit

public class WidgetSettingEntity: NSObject, NSCoding {
    
    public let widgetStyle : String
    public let background : UIColor?
    public let backgroundImage : UIImage?
    public let fontColor : UIColor?
    public let maskCvv : Bool?
    public let fontFamily : String?
    public let fontSize : Float?
    public let maskCardNumber : Bool?
    public let cvvPaddingTop : String?
    public let showEyeIcon : Bool?
    public let cardNumberPaddingBottom : String?
    public let cvvPaddingLeft : String?
    public let cvvPaddingRight : String?
    public let cardNumberPaddingTop : String?
    public let cvvPaddingBottom : String?
    public let expiryPaddingLeft : String?
    public let expiryPaddingRight : String?
    public let expiryPaddingTop : String?
    public let expiryPaddingBottom : String?
    public let cardNumberPaddingRight : String?
    public let cardNumberPaddingLeft : String?
    public let buttonFontColor : UIColor?
    public let buttonBackground : UIColor?
    public let textFieldVariant: String?
    
    public init(widgetStyle : String,
                background : UIColor? = nil
                ,backgroundImage : UIImage? = nil
                ,fontColor : UIColor? = nil
                ,maskCvv : Bool? = nil
                ,fontFamily : String? = nil
                ,fontSize : Float? = nil
                ,maskCardNumber : Bool? = nil
                ,cvvPaddingTop : String? = nil
                ,showEyeIcon : Bool? = nil
                ,cardNumberPaddingBottom : String? = nil
                ,cvvPaddingLeft : String? = nil
                ,cvvPaddingRight : String? = nil
                ,cardNumberPaddingTop : String? = nil
                ,cvvPaddingBottom : String? = nil
                ,expiryPaddingLeft : String? = nil
                ,expiryPaddingRight : String? = nil
                ,expiryPaddingTop : String? = nil
                ,expiryPaddingBottom : String? = nil
                ,cardNumberPaddingRight : String? = nil
                ,cardNumberPaddingLeft : String? = nil
                ,buttonFontColor : UIColor? = nil
                ,buttonBackground : UIColor? = nil
                ,textFieldVariant: String? = nil) {
        
        self.widgetStyle = widgetStyle
        self.background = background
        self.backgroundImage = backgroundImage
        self.fontColor = fontColor
        self.maskCvv = maskCvv
        self.fontFamily = fontFamily
        self.fontSize = fontSize
        self.maskCardNumber = maskCardNumber
        self.cvvPaddingTop = cvvPaddingTop
        self.showEyeIcon = showEyeIcon
        self.cardNumberPaddingBottom = cardNumberPaddingBottom
        self.cvvPaddingLeft = cvvPaddingLeft
        self.cvvPaddingRight = cvvPaddingRight
        self.cardNumberPaddingTop = cardNumberPaddingTop
        self.cvvPaddingBottom = cvvPaddingBottom
        self.expiryPaddingLeft = expiryPaddingLeft
        self.expiryPaddingRight = expiryPaddingRight
        self.expiryPaddingTop = expiryPaddingTop
        self.expiryPaddingBottom = expiryPaddingBottom
        self.cardNumberPaddingRight = cardNumberPaddingRight
        self.cardNumberPaddingLeft = cardNumberPaddingLeft
        self.buttonFontColor = buttonFontColor
        self.buttonBackground = buttonBackground
        self.textFieldVariant = textFieldVariant
    }
    required public init?(coder aDecoder: NSCoder) {
        
        self.widgetStyle = aDecoder.decodeObject(forKey: "widgetStyle")as? String ?? ""
        self.background = aDecoder.decodeObject(forKey: "background") as? UIColor ?? .blueColor
        self.backgroundImage = aDecoder.decodeObject(forKey: "backgroundImage") as? UIImage ?? nil
        self.fontColor = aDecoder.decodeObject(forKey: "fontColor") as? UIColor ?? .white
        self.maskCvv = aDecoder.decodeObject(forKey: "maskCvv") as? Bool ?? false
        self.fontFamily = aDecoder.decodeObject(forKey: "fontFamily") as? String ?? ""
        self.fontSize = aDecoder.decodeObject(forKey: "fontSize") as? Float ?? 0.0
        self.maskCardNumber = aDecoder.decodeObject(forKey: "maskCardNumber") as? Bool ?? false
        self.cardNumberPaddingTop = aDecoder.decodeObject(forKey: "cardNumberPaddingTop") as? String ?? ""
        self.showEyeIcon = aDecoder.decodeObject(forKey: "showEyeIcon") as? Bool ?? false
        self.cardNumberPaddingBottom = aDecoder.decodeObject(forKey: "cardNumberPaddingBottom") as? String ?? ""
        self.cvvPaddingLeft = aDecoder.decodeObject(forKey: "cvvPaddingLeft") as? String ?? ""
        self.cvvPaddingRight = aDecoder.decodeObject(forKey: "cvvPaddingRight") as? String ?? ""
        self.cvvPaddingTop = aDecoder.decodeObject(forKey: "cvvPaddingTop") as? String ?? ""
        self.cvvPaddingBottom = aDecoder.decodeObject(forKey: "cvvPaddingBottom") as? String ?? ""
        self.expiryPaddingLeft = aDecoder.decodeObject(forKey: "expiryPaddingLeft") as? String ?? ""
        self.expiryPaddingRight = aDecoder.decodeObject(forKey: "expiryPaddingRight") as? String ?? ""
        self.expiryPaddingTop = aDecoder.decodeObject(forKey: "expiryPaddingTop") as? String ?? ""
        self.expiryPaddingBottom = aDecoder.decodeObject(forKey: "expiryPaddingBottom") as? String ?? ""
        self.cardNumberPaddingRight = aDecoder.decodeObject(forKey: "cardNumberPaddingRight") as? String ?? ""
        self.cardNumberPaddingLeft = aDecoder.decodeObject(forKey: "cardNumberPaddingLeft") as? String ?? ""
        self.buttonFontColor = aDecoder.decodeObject(forKey: "buttonFontColor") as? UIColor ?? .white
        self.buttonBackground = aDecoder.decodeObject(forKey: "buttonBackground") as? UIColor ?? .blueColor
        self.textFieldVariant = aDecoder.decodeObject(forKey: "textFieldVariant") as? String ?? ""
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(widgetStyle, forKey: "widgetStyle")
        aCoder.encode(background, forKey: "background")
        aCoder.encode(backgroundImage, forKey: "backgroundImage")
        aCoder.encode(fontColor, forKey: "fontColor")
        aCoder.encode(maskCvv, forKey: "maskCvv")
        aCoder.encode(fontFamily, forKey: "fontFamily")
        aCoder.encode(fontSize, forKey: "fontSize")
        aCoder.encode(maskCardNumber, forKey: "maskCardNumber")
        aCoder.encode(cardNumberPaddingTop, forKey: "cardNumberPaddingTop")
        aCoder.encode(showEyeIcon, forKey: "showEyeIcon")
        aCoder.encode(cardNumberPaddingBottom, forKey: "cardNumberPaddingBottom")
        aCoder.encode(cvvPaddingLeft, forKey: "cvvPaddingLeft")
        aCoder.encode(cvvPaddingRight, forKey: "cvvPaddingRight")
        aCoder.encode(cvvPaddingTop, forKey: "cvvPaddingTop")
        aCoder.encode(cvvPaddingBottom, forKey: "cvvPaddingBottom")
        aCoder.encode(expiryPaddingLeft, forKey: "expiryPaddingLeft")
        aCoder.encode(expiryPaddingRight, forKey: "expiryPaddingRight")
        aCoder.encode(expiryPaddingTop, forKey: "expiryPaddingTop")
        aCoder.encode(expiryPaddingBottom, forKey: "expiryPaddingBottom")
        aCoder.encode(cardNumberPaddingRight, forKey: "cardNumberPaddingRight")
        aCoder.encode(cardNumberPaddingLeft, forKey: "cardNoLeft")
        aCoder.encode(buttonFontColor, forKey: "buttonFontColor")
        aCoder.encode(buttonBackground, forKey: "buttonBackground")
        aCoder.encode(textFieldVariant, forKey: "textFieldVariant")
        
    }
}
