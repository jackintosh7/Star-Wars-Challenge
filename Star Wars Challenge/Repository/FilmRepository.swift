//
//  FilmRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class FilmRepository {
    
    /// Search By Movie Title
    /// - Parameters:
    ///   - title: Title
    ///   - page: Page
    ///   - completion: Return array of MovieModels or return an error if faliure
    func fetchAll(
        page: Int,
        completion: @escaping (Result<FilmsData, Error>) -> ()
    ) {
        let request = API.Films.FetchAll.Request(page: page)
        API.Films.FetchAll(request: request).invoke { result in
            switch result {
            case .success(let response):
                let filmData = FilmsData.init(films: response.films, totalResults: response.totalResults)
                completion(.success(filmData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
