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

    static let pinEmpty = "PIN is required"
    static let confirmPinEmpty = "Confirm PIN is required"
    static let pinMismatch = "PIN and New PIN must be same"
    static let pinDifferent = "Old PIN and New PIN must be different"
    static let newpinMismatch = "New PIN and Confirm New PIN must be same"
    static let pinRequired = "PIN (required)*"
    static let pinlength = "PIN Must be Valid"
    static let newPinlength = "New PIN Must be Valid"
    static let confirmPinlength = "Confirm PIN Must be Valid"
    static let confirmNewPinlength = "Confirm New PIN Must be Valid"
    static let oldPinlength = "Old PIN Must be Valid"
    static let ok = "OK"
    static let cardPinSuccess = "Card Pin is Set Sucessfully"
    static let cardPinChangeSuccess = "Card Pin is Changed Sucessfully"
    
    static let exmapleApp = "com.example.app"
    static let encryptionTextNil = "Encrypted text is nil"
    static let  invalidKey = "Invalid key format"
    static let invalidFormat = "Invalid input format"
    static let invalidIVFormat = "Invalid IV format"
    static let invalidEncryptDataFormat = "Invalid encrypted data format"
    static let decryptionFailed = "Decryption failed: Unable to convert decrypted data to UTF-8 string"
    static let randomBytesGenerationError = "RandomBytesGenerationError"
    static let cipherError = "CipherCreationError"
    static let encryptError = "EncryptionError"
    static let decryptFail = "Decryption failed:"
    static let xxx = "XXX"
    static let cardXDigit = "XXXX XXXX XXXX"
    static let viewCard = "View Card"
    static let outlined = "Outlined"
    static let filled = "Filled"
    static let cardInActivate = "Card not in Activated State"
    static let activated = "activated"
}

enum ColorConstant {
    static let lightGrayColor = "#D0D5DD"
}

enum ImageConstant {
    static let eyeImage = "eye.png"
    static let eyeOffImage = "eye-off.png"
}

enum FontConstant {
    static let euclidFlexMediumFont = "EuclidFlex-Medium"
    static let interMedium = "Inter-Medium"
}

enum APIConstant {
    static let token = "token"
    static let deviceFingerprint = "deviceFingerprint"
    static let devicePrint = "device_fingerprint"
    static let pin = "pin"
    static let oldPin = "old_pin"
    static let newPin = "new_pin"
}

enum JailBreakUrl {
    static let uri = "/private/var/lib/apt"
}
