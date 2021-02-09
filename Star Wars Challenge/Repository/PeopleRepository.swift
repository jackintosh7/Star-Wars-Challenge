//
//  PeopleRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class PeopleRepository {
    
    func fetchByID(
        id: String,
        completion: @escaping (Result<PeopleModel, Error>) -> ()
    ) {
        let request = API.People.FetchByID.Request(id: id)
        API.People.FetchByID(request: request).invoke { result in
            switch result {
            case .success(let person):
                completion(.success(person))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
