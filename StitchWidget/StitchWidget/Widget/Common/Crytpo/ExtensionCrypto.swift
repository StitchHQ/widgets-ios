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
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
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
    
    let hexDigest = deviceFigerprint.data(using: .ascii)!.sha256

    print("md5Hex: \(hexDigest)")
    return hexDigest
}
private func hexString(_ iterator: Array<UInt8>.Iterator) -> String {
    return iterator.map { String(format: "%02x", $0) }.joined()
}
extension Data {

    public var sha256: String {
        if #available(iOS 13.0, *) {
            return hexString(SHA256.hash(data: self).makeIterator())
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            self.withUnsafeBytes { bytes in
                _ = CC_SHA256(bytes.baseAddress, CC_LONG(self.count), &digest)
            }
            return hexString(digest.makeIterator())
        }
    }

}
