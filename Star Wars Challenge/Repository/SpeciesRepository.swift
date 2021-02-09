//
//  SpeciesRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class SpeciesRepository {
    
    /// Search By Movie Title
    /// - Parameters:
    ///   - title: Title
    ///   - page: Page
    ///   - completion: Return array of MovieModels or return an error if faliure
    func fetchAll(
        page: Int,
        completion: @escaping (Result<SpeciesData, Error>) -> ()
    ) {
        let request = API.Species.FetchAll.Request(page: page)
        API.Species.FetchAll(request: request).invoke { result in
            switch result {
            case .success(let response):
                let speciesData = SpeciesData.init(species: response.species, totalResults: response.totalResults)
                completion(.success(speciesData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchByID(
        id: String,
        completion: @escaping (Result<SpeciesModel, Error>) -> ()
    ) {
        let request = API.Species.FetchByID.Request(id: id)
        API.Species.FetchByID(request: request).invoke { result in
            switch result {
            case .success(let species):
                completion(.success(species))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
