//
//  VehiclesRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

class VehiclesRepository {
  
//    ALTERNATIVE TO FETCH ITEMS IN CATEGORY
//    func fetchAll(
//        page: Int,
//        completion: @escaping (Result<VehiclesData, Error>) -> ()
//    ) {
//        let request = API.Vehicles.FetchAll.Request(page: page)
//        API.Vehicles.FetchAll(request: request).invoke { result in
//            switch result {
//            case .success(let response):
//                let vehiclesData = VehiclesData.init(vehicles: response.vehicles, totalResults: response.totalResults)
//                completion(.success(vehiclesData))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    func fetchByID(
        id: String,
        completion: @escaping (Result<VehiclesModel, Error>) -> ()
    ) {
        if let vehicle = try? Realm().object(ofType: VehiclesModel.self, forPrimaryKey: id) {
            completion(.success(vehicle))
        } else {
            let request = API.Vehicles.FetchByID.Request(id: id)
            API.Vehicles.FetchByID(request: request).invoke { result in
                switch result {
                case .success(let vehicle):
                    try? Realm().write { realm in
                        realm.add(vehicle, update: .modified)
                    }
                    completion(.success(vehicle))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
