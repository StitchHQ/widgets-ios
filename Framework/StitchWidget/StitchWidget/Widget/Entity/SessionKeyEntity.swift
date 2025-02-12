//
//  SessionKeyEntity.swift
//  Stitchdemo
//
//  Created by vizhi on 02/08/23.
//

import Foundation

struct SessionKeyEntity : Codable {
    let token : String?
    let key: String?
    enum CodingKeys: String, CodingKey {
        
        case token = "token"
        case key = "key"
    }
}

struct setPinSuccess : Codable {
    let status : String?
    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
}
