//
//  ApiClient.swift
//  cats
//
//  Created by Майя Калицева on 27.10.2022.
//

import UIKit

class ApiClient {
    
    enum Identifiers {
        static let baseDomen = "https://api.thecatapi.com/v1"
        static let apiKey = "live_ZLzAdyb1GsEWfxlI7UQJLT2ic8KviKaSp1xbn25g5EAHFQyG7XnnnXV2Fp6vfeYX"
        static let uuid = UUID().uuidString
    }
    
    enum ApiClientEndpoint {
        
        case allCats
        case breeds
        case favourites
        case uploads
        case categories
        
        func urlString() -> String {
            switch self {
            case .allCats:
                return "\(Identifiers.baseDomen)/images/search"
            case .breeds:
                return "\(Identifiers.baseDomen)/breeds"
            case .favourites:
                return "\(Identifiers.baseDomen)/favourites"
            case .uploads:
                return "\(Identifiers.baseDomen)/images/upload"
            case .categories:
                return "\(Identifiers.baseDomen)/categories"
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let urlSession = URLSession.shared
    private var dataTask: URLSessionDataTask?

}
