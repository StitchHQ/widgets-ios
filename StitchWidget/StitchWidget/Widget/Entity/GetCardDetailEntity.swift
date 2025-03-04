//
//  GetCardDetailEntity.swift
//  Stitchdemo
//
//  Created by vizhi on 02/08/23.
//

import Foundation


internal struct GetCardDetailEntity : Codable {   
    let items : Items?
    let status : String?
    enum CodingKeys: String, CodingKey {
        
        case items = "items"
        case status = "status"
    }
}

internal struct Items : Codable {
    let cardId : String?
    let cardNumber : String?
    let productId : String?
    let panFirstSix : String?
    let panLastFour : String?
    let sequenceNumber : String?
    let pinFailCount : String?
    let expiry : String?
    let embossedName : String?
    let personId : String?
    let customerId : String?
    let accountId : [String]?
    let cvv2 : String?
    let creationTime : String?
    let modifiedTime : String?
    let discardTime : String?
    
    enum CodingKeys: String, CodingKey {
        
        case cardId = "cardId"
        case cardNumber = "cardNumber"
        case productId = "productId"
        case panFirstSix = "panFirstSix"
        case panLastFour = "panLastFour"
        case sequenceNumber = "sequenceNumber"
        case pinFailCount = "pinFailCount"
        case expiry = "expiry"
        case embossedName = "embossedName"
        case personId = "personId"
        case customerId = "customerId"
        case accountId = "accountId"
        case cvv2 = "cvv2"
        case creationTime = "creationTime"
        case modifiedTime = "modifiedTime"
        case discardTime = "discardTime"
    }
}


