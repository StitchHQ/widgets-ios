//
//  Constant.swift
//  Stitchdemo
//
//  Created by vizhi on 14/08/23.
//

import Foundation

enum ConstantData {
    static let oldPinEmpty = "Old PIN is required"
    static let newPinEmpty = "New PIN is required"
    static let confirmNewPinEmpty = "Confirm New PIN is required"

    static let cvvEmpty = "CVV is required"
    static let activateCardSuccess = "Card Activated Successfully"

    static let pinEmpty = "PIN is required"
    static let confirmPinEmpty = "Confirm PIN is required"
    static let pinMismatch = "PIN and New PIN must be same"
    static let pinDifferent = "Old PIN and New PIN must be different"
    static let newpinMismatch = "New PIN and Confirm New PIN must be same"

    static let pinlength = "PIN Must be Valid"
    static let newPinlength = "New PIN Must be Valid"
    static let confirmPinlength = "Confirm PIN Must be Valid"
    static let confirmNewPinlength = "Confirm New PIN Must be Valid"
    static let oldPinlength = "Old PIN Must be Valid"
    static let ok = "OK"

}
func setDeviceFingerPrint()-> String{
    let strIPAddress : String = getIPAddress()
    let modelName = UIDevice.modelName
    let device = UIDevice.current
    let iosVersion = device.systemVersion
    let deviceFigerprint = "\(strIPAddress) : \(modelName) : \(device) : \(iosVersion)"
    
    let md5Data = MD5(string:deviceFigerprint)

    let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
    print("md5Hex: \(md5Hex)")
    return md5Hex
}
