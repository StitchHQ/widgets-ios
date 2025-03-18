//
//  AESUtils.swift
//  Stitchdemo
//
//  Created by vizhi on 03/08/23.
//

import Foundation
import CryptoSwift

internal class AESUtils {
    
    func decrypt(encryptedText: String?, key: String) throws -> String {
        guard let encryptedText = encryptedText else {
            throw NSError(domain: ConstantData.exmapleApp, code: -1, userInfo: [NSLocalizedDescriptionKey: ConstantData.encryptionTextNil])
        }
        
        guard let keyData = Data(base64Encoded: key) else {
            throw NSError(domain: ConstantData.exmapleApp, code: -1, userInfo: [NSLocalizedDescriptionKey: ConstantData.invalidKey])
        }
        
        let parts = encryptedText.split(separator: ".").map(String.init)
        guard parts.count == 2 else {
            throw NSError(domain: ConstantData.exmapleApp, code: -1, userInfo: [NSLocalizedDescriptionKey: ConstantData.invalidFormat])
        }
        
        guard let ivData = Data(base64Encoded: parts[0]) else {
            throw NSError(domain: ConstantData.exmapleApp, code: -1, userInfo: [NSLocalizedDescriptionKey: ConstantData.invalidIVFormat])
        }
        
        guard let encryptedData = Data(base64Encoded: parts[1]) else {
            throw NSError(domain: ConstantData.exmapleApp, code: -1, userInfo: [NSLocalizedDescriptionKey: ConstantData.invalidEncryptDataFormat])
        }
        
        do {
            let aes = try AES(key: keyData.bytes, blockMode: GCM(iv: ivData.bytes,mode: .combined), padding: .noPadding)
            let decryptedBytes = try aes.decrypt(encryptedData.bytes)
            guard let decryptedText = String(bytes: decryptedBytes, encoding: .utf8) else {
                throw NSError(domain: ConstantData.exmapleApp, code: -1, userInfo: [NSLocalizedDescriptionKey: ConstantData.decryptionFailed])
            }
            return decryptedText
        } catch {
            throw NSError(domain: ConstantData.exmapleApp, code: -1, userInfo: [NSLocalizedDescriptionKey: "\(ConstantData.decryptFail) \(error)"])
        }
    }
    
    func encrypt(pin: String, key: String) throws -> String {
        guard let keyData = Data(base64Encoded: key) else {
            throw NSError(domain: ConstantData.encryptError, code: -1, userInfo: [NSLocalizedDescriptionKey: ConstantData.invalidKey])
        }
        
        let ivBytes = try generateRandomBytes(count: 12)
        let ivBase64 = ivBytes.base64EncodedString()
        
        guard let cipher = try? createCipher(keyData: keyData, ivBytes: ivBytes) else {
            throw NSError(domain: ConstantData.cipherError, code: -2, userInfo: nil)
        }
        
        guard let encryptedData = try? cipher.encrypt(Array(pin.utf8)) else {
            throw NSError(domain: ConstantData.encryptError, code: -3, userInfo: nil)
        }
        
        let encryptedText = Data(encryptedData).base64EncodedString()
        
        return "\(ivBase64).\(encryptedText)"
    }

    func generateRandomBytes(count: Int) throws -> Data {
        var data = Data(count: count)
        let result = data.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, count, $0.baseAddress!)
        }
        guard result == errSecSuccess else {
            throw NSError(domain: ConstantData.randomBytesGenerationError, code: Int(result), userInfo: nil)
        }
        return data
    }

    func createCipher(keyData: Data, ivBytes: Data) throws -> AES? {
        do {
            let cipher = try AES(key: keyData.bytes, blockMode: GCM(iv: ivBytes.bytes,mode: .combined), padding: .noPadding)
            return cipher
        } catch {
            throw NSError(domain: ConstantData.cipherError, code: -4, userInfo: nil)
        }
    }
    
}
