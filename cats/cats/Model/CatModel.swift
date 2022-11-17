//
//  BreedsModel.swift
//  cats
//
//  Created by Майя Калицева on 26.10.2022.
//

import Foundation

struct CatModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imageUrlString = "url"
        case breeds = "breeds"
        case categories = "categories"
    }
    
    // MARK: - Public Properties
    
    let identifier: String
    var breeds: [BreedsModel]
    var imageUrl: URL? {
        return URL(string: imageUrlString)
    }
    let imageUrlString: String
    var categories: [CategoryModel]
}
