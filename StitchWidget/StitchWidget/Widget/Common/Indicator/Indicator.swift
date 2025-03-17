//
//  Indicator.swift
//  Stitchdemo
//
//  Created by vizhi on 26/07/23.
//

import Foundation
import UIKit

public class Indicator {

    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var activityIndicator = UIActivityIndicatorView()

    init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        activityIndicator.style = .large
        activityIndicator.center = blurImg.center
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor.blueColor
    }

    func showIndicator(){
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        DispatchQueue.main.async( execute: {

            keyWindow?.addSubview(self.blurImg)
            keyWindow?.addSubview(self.activityIndicator)
        })
    }
    func hideIndicator(){

        DispatchQueue.main.async( execute:
            {
                self.blurImg.removeFromSuperview()
                self.activityIndicator.removeFromSuperview()
        })
    }
}
