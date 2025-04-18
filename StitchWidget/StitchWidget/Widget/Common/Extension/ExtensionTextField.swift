//
//  TextFieldExtension.swift
//  Stitchdemo
//
//  Created by vizhi on 12/08/23.
//

import Foundation
import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    func removeBottomBorder() {
            let removebottomline = CALayer()
            removebottomline.frame = CGRect(x: 0,y:self.frame.size.height - 1, width: self.frame.size.width,height: 1)
            removebottomline.backgroundColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0, alpha: 1.0).cgColor
            borderStyle = .none
            self.layer.addSublayer(removebottomline)
            self.layer.masksToBounds = true
        }
}
