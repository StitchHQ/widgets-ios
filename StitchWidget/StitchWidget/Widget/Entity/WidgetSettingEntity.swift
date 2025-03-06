//
//  WidgetSettingEntity.swift
//  StitchDemo
//
//  Created by vizhi on 04/03/25.
//

import Foundation
import UIKit

public class WidgetSettingEntity: NSObject, NSCoding {

    public let type : String
    public let backgroundColor : UIColor?
    public let backgroundImg : UIImage?
    public let fontColor : UIColor?
    public let iscvvMask : Bool?
    public let font : String?
    public let fontSize : Float?
    public let isCardNoMask : Bool?
    public let cardNoTop : String?
    public let isEyeMask : Bool?
    public let cardNoBottom : String?
    public let cvvLeft : String?
    public let cvvRight : String?
    public let cvvTop : String?
    public let cvvBottom : String?
    public let dateLeft : String?
    public let dateRight : String?
    public let dateTop : String?
    public let dateBottom : String?
    public let cardNoRight : String?
    public let cardNoLeft : String?
    public let buttonfontColor : UIColor?
    public let buttonBackgroundColor : UIColor?
    public let expLeft : String?
    public let expRight : String?
    public let expTop : String?
    public let expBottom : String?
    public let styleSheetType: String?
    
    init(type : String,backgroundColor : UIColor? = nil
         ,backgroundImg : UIImage? = nil
         ,fontColor : UIColor? = nil
         ,iscvvMask : Bool? = nil
         ,font : String? = nil
         ,fontSize : Float? = nil
         ,isCardNoMask : Bool? = nil
         ,cardNoTop : String? = nil
         ,isEyeMask : Bool? = nil
         ,cardNoBottom : String? = nil
         ,cvvLeft : String? = nil
         ,cvvRight : String? = nil
         ,cvvTop : String? = nil
         ,cvvBottom : String? = nil
         ,dateLeft : String? = nil
         ,dateRight : String? = nil
         ,dateTop : String? = nil
         ,dateBottom : String? = nil
         ,cardNoRight : String? = nil
         ,cardNoLeft : String? = nil
         ,buttonfontColor : UIColor? = nil
         ,buttonBackgroundColor : UIColor? = nil
         ,expLeft : String? = nil
         ,expRight : String? = nil
         ,expTop : String? = nil
         ,expBottom : String? = nil
         , styleSheetType: String? = nil) {
     
        self.type = type
        self.backgroundColor = backgroundColor
        self.backgroundImg = backgroundImg
        self.fontColor = fontColor
        self.iscvvMask = iscvvMask
        self.font = font
        self.fontSize = fontSize
        self.isCardNoMask = isCardNoMask
        self.cardNoTop = cardNoTop
        self.isEyeMask = isEyeMask
        self.cardNoBottom = cardNoBottom
        self.cvvLeft = cvvLeft
        self.cvvRight = cvvRight
        self.cvvTop = cvvTop
        self.cvvBottom = cvvBottom
        self.dateLeft = dateLeft
        self.dateRight = dateRight
        self.dateTop = dateTop
        self.dateBottom = dateBottom
        self.cardNoRight = cardNoRight
        self.cardNoLeft = cardNoLeft
        self.buttonfontColor = buttonfontColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.expLeft = expLeft
        self.expRight = expRight
        self.expTop = expTop
        self.expBottom = expBottom
        self.styleSheetType = styleSheetType
    }
    required public init?(coder aDecoder: NSCoder) {
          self.type = aDecoder.decodeObject(forKey: "type")as? String ?? ""
        self.backgroundColor = aDecoder.decodeObject(forKey: "backgroundColor") as? UIColor ?? .blueColor
        self.backgroundImg = aDecoder.decodeObject(forKey: "backgroundImg") as? UIImage ?? nil
        self.fontColor = aDecoder.decodeObject(forKey: "fontColor") as? UIColor ?? .white

        self.iscvvMask = aDecoder.decodeObject(forKey: "iscvvMask") as? Bool ?? false

        self.font = aDecoder.decodeObject(forKey: "font") as? String ?? ""

        self.fontSize = aDecoder.decodeFloat(forKey: "fontSize")

        self.isCardNoMask = aDecoder.decodeObject(forKey: "isCardNoMask") as? Bool ?? false

        self.cardNoTop = aDecoder.decodeObject(forKey: "cardNoTop") as? String ?? ""

        self.isEyeMask = aDecoder.decodeObject(forKey: "isEyeMask") as? Bool ?? false

        self.cardNoBottom = aDecoder.decodeObject(forKey: "cardNoBottom") as? String ?? ""

        self.cvvLeft = aDecoder.decodeObject(forKey: "cvvLeft") as? String ?? ""

        self.cvvRight = aDecoder.decodeObject(forKey: "cvvRight") as? String ?? ""

        self.cvvTop = aDecoder.decodeObject(forKey: "cvvTop") as? String ?? ""

        self.cvvBottom = aDecoder.decodeObject(forKey: "cvvBottom") as? String ?? ""
        self.dateLeft = aDecoder.decodeObject(forKey: "dateLeft") as? String ?? ""
        self.dateRight = aDecoder.decodeObject(forKey: "dateRight") as? String ?? ""

        self.dateTop = aDecoder.decodeObject(forKey: "dateTop") as? String ?? ""

        self.dateBottom = aDecoder.decodeObject(forKey: "dateBottom") as? String ?? ""

        self.cardNoRight = aDecoder.decodeObject(forKey: "cardNoRight") as? String ?? ""

        self.cardNoLeft = aDecoder.decodeObject(forKey: "cardNoLeft") as? String ?? ""
        
        self.buttonfontColor = aDecoder.decodeObject(forKey: "buttonfontColor") as? UIColor ?? .white
        self.buttonBackgroundColor = aDecoder.decodeObject(forKey: "buttonBackgroundColor") as? UIColor ?? .blueColor
        self.expLeft = aDecoder.decodeObject(forKey: "expLeft") as? String ?? ""
        self.expRight = aDecoder.decodeObject(forKey: "expRight") as? String ?? ""
        self.expTop = aDecoder.decodeObject(forKey: "expTop") as? String ?? ""
        self.expBottom = aDecoder.decodeObject(forKey: "expBottom") as? String ?? ""
        self.styleSheetType = aDecoder.decodeObject(forKey: "styleSheetType") as? String ?? ""

      }

    public func encode(with aCoder: NSCoder) {
          aCoder.encode(type, forKey: "type")
          aCoder.encode(backgroundColor, forKey: "backgroundColor")
          aCoder.encode(backgroundImg, forKey: "backgroundImg")
          aCoder.encode(fontColor, forKey: "fontColor")
          aCoder.encode(iscvvMask, forKey: "iscvvMask")
          aCoder.encode(font, forKey: "font")
          aCoder.encode(fontSize, forKey: "fontSize")
          aCoder.encode(isCardNoMask, forKey: "isCardNoMask")
          aCoder.encode(cardNoTop, forKey: "cardNoTop")
          aCoder.encode(isEyeMask, forKey: "isEyeMask")
          aCoder.encode(cardNoBottom, forKey: "cardNoBottom")
          aCoder.encode(cvvLeft, forKey: "cvvLeft")
          aCoder.encode(cvvRight, forKey: "cvvRight")
          aCoder.encode(cvvTop, forKey: "cvvTop")
          aCoder.encode(cvvBottom, forKey: "cvvBottom")
          aCoder.encode(dateLeft, forKey: "dateLeft")
          aCoder.encode(dateRight, forKey: "dateRight")
          aCoder.encode(dateTop, forKey: "dateTop")
          aCoder.encode(dateBottom, forKey: "dateBottom")
          aCoder.encode(cardNoRight, forKey: "cardNoRight")
          aCoder.encode(cardNoLeft, forKey: "cardNoLeft")
          aCoder.encode(buttonfontColor, forKey: "buttonfontColor")
          aCoder.encode(buttonBackgroundColor, forKey: "buttonBackgroundColor")
          aCoder.encode(expLeft, forKey: "expLeft")
          aCoder.encode(expRight, forKey: "expRight")
          aCoder.encode(expTop, forKey: "expTop")
          aCoder.encode(expBottom, forKey: "expBottom")
          aCoder.encode(styleSheetType, forKey: "styleSheetType")

      }
}
