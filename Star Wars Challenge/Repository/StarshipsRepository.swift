//
//  StarshipsRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class StarshipsRepository {
    
    func fetchAll(
        page: Int,
        completion: @escaping (Result<StarshipsData, Error>) -> ()
    ) {
        let request = API.Starships.FetchAll.Request(page: page)
        API.Starships.FetchAll(request: request).invoke { result in
            switch result {
            case .success(let response):
                let starshipsData = StarshipsData.init(starships: response.starships, totalResults: response.totalResults)
                completion(.success(starshipsData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
