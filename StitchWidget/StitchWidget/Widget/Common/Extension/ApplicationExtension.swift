//
//  ApplicationExtension.swift
//  Stitchdemo
//
//  Created by vizhi on 14/08/23.
//

import Foundation
import UIKit

extension UIApplication {
    
    //To the the topview controller of the application
    class func topViewController(base: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
}
func showAlertMessage(str: String){
    simpleAlert(view: UIApplication.topViewController()!.self, title: String.Empty, message: str,buttonTitle: ConstantData.ok)
}
