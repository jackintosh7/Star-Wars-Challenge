//
//  PlanetsModel.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

final class PlanetsModel: Object, Decodable {
    
    override class func primaryKey() -> String? { "id" }
    
    @objc dynamic var id: String = ""
    
    @objc dynamic var name: String = ""
    @objc dynamic var diameter: String = ""
    @objc dynamic var rotationPeriod: String = ""
    @objc dynamic var orbitalPeriod: String = ""
    @objc dynamic var gravity: String = ""
    @objc dynamic var population: String = ""
    @objc dynamic var climate: String = ""
    @objc dynamic var terrain: String = ""
    @objc dynamic var surfaceWater: String = ""
    @objc dynamic var residents: [String]?
    @objc dynamic var films: [String]?
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
        diameter = try container.decode(.diameter)
        rotationPeriod = try container.decode(.rotationPeriod)
        orbitalPeriod = try container.decode(.orbitalPeriod)
        gravity = try container.decode(.gravity)
        population = try container.decode(.population)
        climate = try container.decode(.climate)
        terrain = try container.decode(.terrain)
        surfaceWater = try container.decode(.surfaceWater)
        residents = try? container.decodeIfPresent(.residents)
        films = try? container.decodeIfPresent(.films)
        url = try container.decode(.url)
        created = try container.decode(.created)
        edited = try container.decode(.edited)
    }
}

extension PlanetsModel {
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case diameter = "diameter"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case gravity = "gravity"
        case population = "population"
        case climate = "climate"
        case terrain = "terrain"
        case surfaceWater = "surface_water"
        case residents = "residents"
        case films = "films"
        case url = "url"
        case created = "created"
        case edited = "edited"
    }
}
