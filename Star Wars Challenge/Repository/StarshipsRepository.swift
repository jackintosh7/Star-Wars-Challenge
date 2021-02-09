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
        let request = API.Starships.FetchByID.Request(id: id)
        API.Starships.FetchByID(request: request).invoke { result in
            switch result {
            case .success(let starships):
                completion(.success(starships))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
