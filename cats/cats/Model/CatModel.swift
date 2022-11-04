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
    var categories: [CategoryModel]
    var imageUrl: URL? {
        return URL(string: imageUrlString)
    }
    let imageUrlString: String
    
    // MARK: - Init + Decoding
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try value.decode(String.self, forKey: .identifier)
        imageUrlString = try value.decode(String.self, forKey: .imageUrlString)
        breeds = try value.decode([BreedsModel].self, forKey: .breeds)
        categories = try value.decode([CategoryModel].self, forKey: .categories)
    }
}
