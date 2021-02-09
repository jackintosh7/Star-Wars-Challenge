//
//  API+Starships+FetchByID.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import Alamofire

extension API.Starships {
    
    struct FetchByID: APIService {
        
        struct Request: Encodable {
            let id: String
        }
        
        typealias Response = StarshipsModel
        
        var path: String { "/starships/" + self.request!.id}
        var method: Alamofire.HTTPMethod { .get }
        let request: Request?
        
        init(request: Request) {
            self.request = request
        }
    }
}
