//
//  JailBreak.swift
//  StitchWidget
//
//  Created by vizhi on 14/03/25.
//


/**
 Detect that the app is running on a jailbroken device or not
 
 - returns: bool value for jailbroken device or not
 */
public func hasJailbreak() -> CardSDKError {
    #if arch(i386) || arch(x86_64)
        return CardSDKError.secureEnvironment
    #else
    let fileManager = FileManager.default
    if(fileManager.fileExists(atPath: JailBreakUrl.uri)) {
            return CardSDKError.insecureEnvironment
        } else {
            return CardSDKError.secureEnvironment
        }
    #endif
}


public enum CardSDKError: Error {
    case insecureEnvironment
    case secureEnvironment
    
    var code: Int {
        switch self {
        case .insecureEnvironment:
            return 1001
        case .secureEnvironment:
            return 200
        }
    }
    var localizedDescription: String {
        switch self {
        case .insecureEnvironment:
            // This message is generic and safe to display
            return NSLocalizedString("Insecure environment detected. Please use a secure device.", comment: "Error message for insecure environment")
        case .secureEnvironment:
            return NSLocalizedString("secure environment detected.", comment: "Error message for secure environment")
        }
    }
}
