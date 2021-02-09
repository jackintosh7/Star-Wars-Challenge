//
//  PeopleModel.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/3/21.
//

import Foundation
import RealmSwift

final class PeopleModel: Object, Decodable {
    
    override class func primaryKey() -> String? { "id" }
    
    @objc dynamic var id: String = ""
    
    @objc dynamic var name: String = ""
    @objc dynamic var birthYear: String = ""
    @objc dynamic var eyeColor: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var hairColor: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var mass: String = ""
    @objc dynamic var skinColor: String = ""
    @objc dynamic var homeworld: String = ""
    var films = List<String>()
    var species = List<String>()
    var starships = List<String>()
    var vehicles = List<String>()
    @objc dynamic var url: String = ""
    @objc dynamic var created: String = ""
    @objc dynamic var edited: String = ""

    override init() {
        super.init()
    }
    
    init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.name)
        name = try container.decode(.name)
        birthYear = try container.decode(.birthYear)
        eyeColor = try container.decode(.eyeColor)
        gender = try container.decode(.gender)
        hairColor = try container.decode(.hairColor)
        height = try container.decode(.height)
        mass = try container.decode(.mass)
        skinColor = try container.decode(.skinColor)
        homeworld = try container.decode(.homeworld)
        films = try container.decode(.films)
        species = try container.decode(.species)
        starships = try container.decode(.starships)
        vehicles = try container.decode(.vehicles)
        url = try container.decode(.url)
        created = try container.decode(.created)
        edited = try container.decode(.edited)
    }
}

extension PeopleModel {
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case gender = "gender"
        case hairColor = "hair_color"
        case height = "height"
        case mass = "mass"
        case skinColor = "skin_color"
        case homeworld = "homeworld"
        case films = "films"
        case species = "species"
        case starships = "starships"
        case vehicles = "vehicles"
        case url = "url"
        case created = "created"
        case edited = "edited"
    }
}
