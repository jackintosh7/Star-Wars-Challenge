//
//  PlanetsRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class PlanetsRepository {
    func fetchByID(
        id: String,
        completion: @escaping (Result<PlanetsModel, Error>) -> ()
    ) {
        if let planet = try? Realm().object(ofType: PlanetsModel.self, forPrimaryKey: id) {
            completion(.success(planet))
        } else {
            let request = API.Planets.FetchByID.Request(id: id)
            API.Planets.FetchByID(request: request).invoke { result in
                switch result {
                case .success(let planet):
                    try? Realm().write { realm in
                        realm.add(planet, update: .modified)
                    }
                    completion(.success(planet))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
