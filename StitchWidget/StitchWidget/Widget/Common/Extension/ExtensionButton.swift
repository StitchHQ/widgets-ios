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
/**
     Detect that the app is running on a jailbroken device or not

     - returns: bool value for jailbroken device or not
     */
public func isDeviceJailbroken() -> Bool {
        #if arch(i386) || arch(x86_64)
            return false
        #else
            let fileManager = FileManager.default

            if (fileManager.fileExists(atPath: "/bin/bash") ||
                fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
                fileManager.fileExists(atPath: "/etc/apt") ||
                fileManager.fileExists(atPath: "/private/var/lib/apt/") ||
                fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
                fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")) {
                return true
            } else {
                return false
            }
        #endif
    }
