//
//  ExtensionCrypto.swift
//  Stitchdemo
//
//  Created by vizhi on 11/09/23.
//

import Foundation
import UIKit
import CryptoKit
import CommonCrypto

func getIPAddress() -> String {
    var address: String?
    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }

            guard let interface = ptr?.pointee else { return "" }
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                let name: String = String(cString: (interface.ifa_name))
                if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
    }
    return address ?? ""
}
public func getDevicFingingerprint()-> String{
    let strIPAddress : String = getIPAddress()
    let modelName = UIDevice.modelName
    let device = UIDevice.current
    let iosVersion = device.systemVersion
    let deviceFigerprint = "\(strIPAddress) : \(modelName) : \(device) : \(iosVersion)"
    
    let md5Str = deviceFigerprint.hash256()
    let md5Data = Data(md5Str.utf8)

    let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
    print("md5Hex: \(md5Hex)")
    return md5Hex
}
extension String {
    func hash256() -> String {
        let inputData = Data(utf8)
        
        if #available(iOS 13.0, *) {
            let hashed = SHA256.hash(data: inputData)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            inputData.withUnsafeBytes { bytes in
                _ = CC_SHA256(bytes.baseAddress, UInt32(inputData.count), &digest)
            }
            return digest.makeIterator().compactMap { String(format: "%02x", $0) }.joined()
        }
    }
}
