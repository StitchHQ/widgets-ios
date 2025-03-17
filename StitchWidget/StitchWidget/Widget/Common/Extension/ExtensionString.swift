//
//  ExtensionString.swift
//  Stitchdemo
//
//  Created by vizhi on 14/08/23.
//

import Foundation

extension String {
    var isValid6Password: Bool {
        return self.count >= 6
    }
    
    var isValid4Password: Bool {
        return self.count >= 4
    }
    
    //Check sting is empty
    static var Empty: String {
        return ""
    }
    
    func firstWord() -> String? {
        return self.components(separatedBy: "-").first
    }
    
    func cgFloatValue() -> CGFloat? {
        guard let doubleValue = Double(self) else {
            return nil
        }
        
        return CGFloat(doubleValue)
    }
}

