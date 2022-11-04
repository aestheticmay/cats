//
//  BreedsModel.swift
//  cats
//
//  Created by Майя Калицева on 02.11.2022.
//

import Foundation

struct BreedsModel: Codable {
    
    // MARK: Public Properties
    
    let id: String
    let name: String
    
    // MARK: Init
    /*
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(String.self, forKey: .id)
    }
     */
}
