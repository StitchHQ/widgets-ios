//
//  ExtensionButton.swift
//  Stitchdemo
//
//  Created by vizhi on 12/08/23.
//

import Foundation
import UIKit

extension UIButton {
    
    //Set cornor radius based on width or height
    func setCornerRadius() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
    func setCornerRadiusButton(size: CGFloat) {
        self.layer.cornerRadius = size
        self.layer.masksToBounds = true
    }
}
