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
        private static let apiHost: String = "https://api.thecatapi.com/v1"
        
        case allCats
        case breeds
        case categories
        case favourites
        case uploads
        
        func urlString() -> String {
            switch self {
            case .allCats:
                return "\(ApiClientEndpoint.apiHost)/images/search"
            case .breeds:
                return "\(ApiClientEndpoint.apiHost)/breeds"
            case .categories:
                return "\(ApiClientEndpoint.apiHost)/categories"
            case .favourites:
                return "\(ApiClientEndpoint.apiHost)/favourites"
            case .uploads:
                return "\(ApiClientEndpoint.apiHost)/images/upload"
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let urlSession = URLSession.shared
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Public Methods
    
   
}
