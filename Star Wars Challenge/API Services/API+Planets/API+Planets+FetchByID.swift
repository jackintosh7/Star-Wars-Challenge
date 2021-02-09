//
//  API+Planets+FetchByID.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import Alamofire

extension API.Planets {
    
    struct FetchByID: APIService {
        
        struct Request: Encodable {
            let id: String
        }
        
        typealias Response = PlanetsModel
        
        var path: String { "/planets/" + self.request!.id}
        var method: Alamofire.HTTPMethod { .get }
        let request: Request?
        
        init(request: Request) {
            self.request = request
        }
    }
}
