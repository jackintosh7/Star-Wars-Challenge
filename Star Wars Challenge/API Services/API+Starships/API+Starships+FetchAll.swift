//
//  API+Starships+FetchAll.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import Alamofire

extension API.Starships {
    
    struct FetchAll: APIService {
        
        struct Request: Encodable {
            
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
           
           let starships: [StarshipsModel]
           let totalResults: Int
           
           enum CodingKeys: String, CodingKey {
              
              case starships = "results"
              case totalResults = "count"
           }
        }
        var path: String { "/starships"}
        var method: Alamofire.HTTPMethod { .get }
        let request: Request?
        
        init(request: Request) {
            self.request = request
        }
    }
}
