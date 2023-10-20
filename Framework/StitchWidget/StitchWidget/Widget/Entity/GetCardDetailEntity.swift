//
//  GetCardDetailEntity.swift
//  Stitchdemo
//
//  Created by vizhi on 02/08/23.
//

import Foundation


struct GetCardDetailEntity : Codable {
    let accountNumber : String?
    let cvv : String?
    let expiry : String?
    
    enum CodingKeys: String, CodingKey {
        
        case accountNumber = "accountNumber"
        case cvv = "cvv"
        case expiry = "expiry"
    }
}
