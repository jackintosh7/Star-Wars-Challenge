//
//  FilmRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class FilmRepository {
    
    func fetchByID(
        id: String,
        completion: @escaping (Result<FilmsModel, Error>) -> ()
    ) {
        let request = API.Films.FetchByID.Request(id: id)
        API.Films.FetchByID(request: request).invoke { result in
            switch result {
            case .success(let film):
                completion(.success(film))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
