//
//  SessionKeyEntity.swift
//  Stitchdemo
//
//  Created by vizhi on 02/08/23.
//

import Foundation

struct SessionKeyEntity : Codable {
    let generatedKey : String?
    
    enum CodingKeys: String, CodingKey {
        
        case generatedKey = "generatedKey"
    }
}
