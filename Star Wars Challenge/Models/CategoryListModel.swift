//
//  CategoryListModel.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/8/21.
//

import Foundation

final class CategoryListModel: NSObject, Decodable {
        
    @objc dynamic var id: String = ""
    
    @objc dynamic var title: String?
    @objc dynamic var subTitle: String?
    @objc dynamic var url: String?
    @objc dynamic var created: String?

    override init() {
        super.init()
    }
    
    init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try? container.decodeIfPresent(.name)
        if title == nil {
            title = try? container.decodeIfPresent(.title)
        }
        
        subTitle = try? container.decodeIfPresent(.openingCrawl)
        if subTitle == nil {
            subTitle = try? container.decodeIfPresent(.birthYear)
        }
        
        if subTitle == nil {
            subTitle = try? container.decodeIfPresent(.diameter)
        }
        
        if subTitle == nil {
            subTitle = try? container.decodeIfPresent(.classification)
        }
        
        if subTitle == nil {
            subTitle = try? container.decodeIfPresent(.model)
        }
        
        url = try? container.decodeIfPresent(.url)
        created = try? container.decodeIfPresent(.created)

    }
}

extension CategoryListModel {
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case title = "title"
        case openingCrawl = "opening_crawl"
        case birthYear = "birth_year"
        case diameter = "diameter"
        case classification = "classification"
        case model = "model"
        case url = "url"
        case created = "created"
    }
}
