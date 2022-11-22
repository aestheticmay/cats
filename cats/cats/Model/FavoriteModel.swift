//
//  FavoriteModel.swift
//  cats
//
//  Created by Майя Калицева on 22.11.2022.
//

import Foundation

struct FavoriteModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageId = "image_id"
        case subId = "sub_id"
        case createdIn = "created_in"
    }
    
    var id: String
    var imageId: String
    var subId: String
    var createdIn: String
}
