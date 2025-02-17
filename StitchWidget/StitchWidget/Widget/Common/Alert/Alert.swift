//
//  Alert.swift
//  StitchWidget
//
//  Created by vizhi on 01/09/23.
//

import Foundation
import UIKit
var onTapAlert: ((Int)->Void)?



//Simple Alert view with button one
func simpleAlert(view: UIViewController, title: String, message: String, buttonTitle: String) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    //okButton Action
    let okButton = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) {
        (result : UIAlertAction) -> Void in
        onTapAlert?(1)
    }
    alert.addAction(okButton)
    view.present(alert, animated: true, completion: nil)
}
