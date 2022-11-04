//
//  CategoriesModel.swift
//  cats
//
//  Created by Майя Калицева on 02.11.2022.
//

import Foundation

struct CategoryModel: Codable {

    // MARK: Public Properties
    
    let id: String
    let name: String
    
    // MARK: Init
    /*
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        id = try value.decode(String.self, forKey: .id)
        name = try value.decode(String.self, forKey: .name)
    }
     */
}
