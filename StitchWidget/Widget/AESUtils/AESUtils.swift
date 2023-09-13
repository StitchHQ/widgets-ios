//
//  AESUtils.swift
//  Stitchdemo
//
//  Created by vizhi on 03/08/23.
//

import Foundation
import CryptoSwift

class AESUtils {
    
    func decrypt(encryptedText: String?, key: String) throws -> String {
        guard let encryptedText = encryptedText else {
            throw NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Encrypted text is nil"])
        }
        
        guard let keyData = Data(base64Encoded: key) else {
            throw NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid key format"])
        }
        
        let parts = encryptedText.split(separator: ".").map(String.init)
        guard parts.count == 2 else {
            throw NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid input format"])
        }
        
        guard let ivData = Data(base64Encoded: parts[0]) else {
            throw NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid IV format"])
        }
        
        guard let encryptedData = Data(base64Encoded: parts[1]) else {
            throw NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid encrypted data format"])
        }
        
        do {
            let aes = try AES(key: keyData.bytes, blockMode: CBC(iv: ivData.bytes), padding: .pkcs5)
            let decryptedBytes = try aes.decrypt(encryptedData.bytes)
            guard let decryptedText = String(bytes: decryptedBytes, encoding: .utf8) else {
                throw NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Decryption failed: Unable to convert decrypted data to UTF-8 string"])
            }
            return decryptedText
        } catch {
            throw NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Decryption failed: \(error)"])
        }
    }
    
    func encrypt(pin: String, key: String) throws -> String {
        guard let keyData = Data(base64Encoded: key) else {
            throw NSError(domain: "EncryptionError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid key format"])
        }
        
        let ivBytes = try generateRandomBytes(count: 16)
        let ivBase64 = ivBytes.base64EncodedString()
        
        guard let cipher = try? createCipher(keyData: keyData, ivBytes: ivBytes) else {
            throw NSError(domain: "CipherCreationError", code: -2, userInfo: nil)
        }
        
        guard let encryptedData = try? cipher.encrypt(Array(pin.utf8)) else {
            throw NSError(domain: "EncryptionError", code: -3, userInfo: nil)
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
            throw NSError(domain: "RandomBytesGenerationError", code: Int(result), userInfo: nil)
        }
        return data
    }

    func createCipher(keyData: Data, ivBytes: Data) throws -> AES? {
        do {
            let cipher = try AES(key: keyData.bytes, blockMode: CBC(iv: ivBytes.bytes), padding: .pkcs5)
            return cipher
        } catch {
            throw NSError(domain: "CipherCreationError", code: -4, userInfo: nil)
        }
    }
    
}
