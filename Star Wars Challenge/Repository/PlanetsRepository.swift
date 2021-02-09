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
        let request = API.Planets.FetchByID.Request(id: id)
        API.Planets.FetchByID(request: request).invoke { result in
            switch result {
            case .success(let planets):
                completion(.success(planets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
