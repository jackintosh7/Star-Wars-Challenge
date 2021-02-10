//
//  SpeciesRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class SpeciesRepository {
    
    func fetchByID(
        id: String,
        completion: @escaping (Result<SpeciesModel, Error>) -> ()
    ) {
        if let species = try? Realm().object(ofType: SpeciesModel.self, forPrimaryKey: id) {
            completion(.success(species))
        } else {
            let request = API.Species.FetchByID.Request(id: id)
            API.Species.FetchByID(request: request).invoke { result in
                switch result {
                case .success(let species):
                    try? Realm().write { realm in
                        realm.add(species, update: .modified)
                    }
                    completion(.success(species))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
