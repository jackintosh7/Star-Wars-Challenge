//
//  CategoryRepository.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/9/21.
//

import Foundation
import RealmSwift

class CategoryRepository {
    
    func fetchAll(
        page: Int,
        category: SWCategories,
        completion: @escaping (Result<CategoryData, Error>) -> ()
    ) {
        let request = API.Category.FetchAll.Request(category: category, page: page)
        API.Category.FetchAll(request: request).invoke { result in
            switch result {
            case .success(let response):
                let filmData = CategoryData.init(categoryItems: response.categoryItems, totalResults: response.totalResults)
                completion(.success(filmData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
