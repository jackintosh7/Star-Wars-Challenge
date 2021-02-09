//
//  FilmsModel.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/3/21.
//

import Foundation
import RealmSwift

final class FilmsModel: Object, Decodable {
    
    override class func primaryKey() -> String? { "id" }
    
    @objc dynamic var id: String = ""
    
    @objc dynamic var title: String = ""
    @objc dynamic var episodeId: Int = 0
    @objc dynamic var openingCrawl: String = ""
    @objc dynamic var director: String = ""
    @objc dynamic var producer: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var species: [String]?
    @objc dynamic var starships: [String]?
    @objc dynamic var vehicles: [String]?
    @objc dynamic var characters: [String]?
    @objc dynamic var planets: [String]?
    @objc dynamic var url: String = ""
    @objc dynamic var created: String = ""
    @objc dynamic var edited: String = ""

    override init() {
        super.init()
    }
    
    init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(.title)
        episodeId = try container.decode(.episodeId)
        openingCrawl = try container.decode(.openingCrawl)
        director = try container.decode(.director)
        producer = try container.decode(.producer)
        releaseDate = try container.decode(.releaseDate)
        species = try? container.decodeIfPresent(.species)
        starships = try? container.decodeIfPresent(.starships)
        vehicles = try? container.decodeIfPresent(.vehicles)
        characters = try? container.decodeIfPresent(.characters)
        planets = try? container.decodeIfPresent(.planets)
        url = try container.decode(.url)
        created = try container.decode(.created)
        edited = try container.decode(.edited)
    }
}

extension FilmsModel {
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case director = "director"
        case producer = "producer"
        case releaseDate = "release_date"
        case species = "species"
        case starships = "starships"
        case vehicles = "vehicles"
        case characters = "characters"
        case planets = "planets"
        case url = "url"
        case created = "created"
        case edited = "edited"
    }
}
