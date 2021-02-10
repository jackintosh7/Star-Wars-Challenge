//
//  SpeciesModel.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

final class SpeciesModel: Object, Decodable {
    
    override class func primaryKey() -> String? { "id" }
    
    @objc dynamic var id: String = ""
    
    @objc dynamic var name: String = ""
    @objc dynamic var classification: String = ""
    @objc dynamic var designation: String = ""
    @objc dynamic var avgHeight: String = ""
    @objc dynamic var avgLifespan: String = ""
    @objc dynamic var eyeColors: String = ""
    @objc dynamic var hairColors: String = ""
    @objc dynamic var skinColors: String = ""
    @objc dynamic var language: String = ""
    @objc dynamic var homeworld: String = ""
    var people = List<String>()
    var films = List<String>()
    @objc dynamic var url: String = ""
    @objc dynamic var created: String = ""
    @objc dynamic var edited: String = ""

    override init() {
        super.init()
    }
    
    init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(.name)
        classification = try container.decode(.classification)
        designation = try container.decode(.designation)
        avgHeight = try container.decode(.avgHeight)
        avgLifespan = try container.decode(.avgLifespan)
        eyeColors = try container.decode(.eyeColors)
        hairColors = try container.decode(.hairColors)
        skinColors = try container.decode(.skinColors)
        language = try container.decode(.language)
        homeworld = try container.decode(.homeworld)
        people = try container.decode(.people)
        films = try container.decode(.films)
        url = try container.decode(.url)
        created = try container.decode(.created)
        edited = try container.decode(.edited)
    }
}

extension SpeciesModel {
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case classification = "classification"
        case designation = "designation"
        case avgHeight = "average_height"
        case avgLifespan = "average_lifespan"
        case eyeColors = "eye_colors"
        case hairColors = "hair_colors"
        case skinColors = "skin_colors"
        case language = "language"
        case homeworld = "homeworld"
        case people = "people"
        case films = "films"
        case url = "url"
        case created = "created"
        case edited = "edited"
    }
}
