//
//  API+Category.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/8/21.
//

import Foundation
import Alamofire

extension API.Category {
    
    struct FetchAll: APIService {
        
        struct Request: Encodable {
            let category: SWCategories

            let page: Int

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(page, forKey: .page)
            }
            
            enum CodingKeys: String, CodingKey {
                case page = "page"
            }
        }
        
        struct Response: Decodable {
           
           let categoryItems: [CategoryListModel]
           let totalResults: Int
           
           enum CodingKeys: String, CodingKey {
              
              case categoryItems = "results"
              case totalResults = "count"
           }
        }
        
        var path: String { "/" + (self.request?.category.rawValue.lowercased())!}
        var method: Alamofire.HTTPMethod { .get }
        let request: Request?
        
        init(request: Request) {
            self.request = request
        }
    }
}
struct CategoryData {
    let categoryItems: [CategoryListModel]
    let totalResults: Int
}
