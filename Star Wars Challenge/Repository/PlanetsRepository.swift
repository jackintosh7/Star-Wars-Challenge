//
//  PlanetsRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class PlanetsRepository {
    
    /// Search By Movie Title
    /// - Parameters:
    ///   - title: Title
    ///   - page: Page
    ///   - completion: Return array of MovieModels or return an error if faliure
    func fetchAll(
        page: Int,
        completion: @escaping (Result<PlanetsData, Error>) -> ()
    ) {
        let request = API.Planets.FetchAll.Request(page: page)
        API.Planets.FetchAll(request: request).invoke { result in
            switch result {
            case .success(let response):
                let planetsData = PlanetsData.init(planets: response.planets, totalResults: response.totalResults)
                completion(.success(planetsData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
