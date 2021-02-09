//
//  PeopleRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class PeopleRepository {
    
    /// Search By Movie Title
    /// - Parameters:
    ///   - title: Title
    ///   - page: Page
    ///   - completion: Return array of MovieModels or return an error if faliure
    func fetchAll(
        page: Int,
        completion: @escaping (Result<PeopleData, Error>) -> ()
    ) {
        let request = API.People.FetchAll.Request(page: page)
        API.People.FetchAll(request: request).invoke { result in
            switch result {
            case .success(let response):
                let peopleData = PeopleData.init(people: response.people, totalResults: response.totalResults)
                completion(.success(peopleData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchByID(
        id: String,
        completion: @escaping (Result<PeopleModel, Error>) -> ()
    ) {
        let request = API.People.FetchByID.Request(id: id)
        API.People.FetchByID(request: request).invoke { result in
            switch result {
            case .success(let person):
                completion(.success(person))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
