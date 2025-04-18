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
            removebottomline.frame = CGRect(x: 0,y:self.frame.size.height - 1, width: self.frame.size.width,height: 0)
        removebottomline.backgroundColor = UIColor.clear.cgColor
            borderStyle = .none
            self.layer.addSublayer(removebottomline)
            self.layer.masksToBounds = true
        }
}
func placeholderPadding(textField:UITextField, leftPadding:CGFloat) {
            textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: leftPadding, height: textField.frame.height))
    textField.leftViewMode = UITextField.ViewMode.always
        }
