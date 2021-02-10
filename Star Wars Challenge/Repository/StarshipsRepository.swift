//
//  StarshipsRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class StarshipsRepository {
    func fetchByID(
        id: String,
        completion: @escaping (Result<StarshipsModel, Error>) -> ()
    ) {
        
        if let starship = try? Realm().object(ofType: StarshipsModel.self, forPrimaryKey: id) {
            completion(.success(starship))
        } else {
            let request = API.Starships.FetchByID.Request(id: id)
            API.Starships.FetchByID(request: request).invoke { result in
                switch result {
                case .success(let starship):
                    try? Realm().write { realm in
                        realm.add(starship, update: .modified)
                    }
                    completion(.success(starship))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
