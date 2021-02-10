//
//  StarshipsModel.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import Foundation
import RealmSwift

final class StarshipsModel: Object, Decodable {
    
    override class func primaryKey() -> String? { "id" }
    
    @objc dynamic var id: String = ""
    
    @objc dynamic var name: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var starshipClass: String = ""
    @objc dynamic var manufacturer: String = ""
    @objc dynamic var costInCredits: String = ""
    @objc dynamic var length: String = ""
    @objc dynamic var crew: String = ""
    @objc dynamic var passengers: String = ""
    @objc dynamic var maxAtmospheringSpeed: String = ""
    @objc dynamic var hyperdriveRating: String = ""
    @objc dynamic var mglt: String = ""
    @objc dynamic var cargoCapacity: String = ""
    @objc dynamic var consumables: String = ""
    var films = List<String>()
    var pilots = List<String>()
    @objc dynamic var url: String = ""
    @objc dynamic var created: String = ""
    @objc dynamic var edited: String = ""

    override init() {
        super.init()
    }
    
    init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //Get URL as string so we can strip the object ID
        let urlStr = try container.decode(String.self, forKey: .url)

        id = urlStr.digits
        url = urlStr
        name = try container.decode(.name)
        model = try container.decode(.model)
        starshipClass = try container.decode(.starshipClass)
        manufacturer = try container.decode(.manufacturer)
        costInCredits = try container.decode(.costInCredits)
        length = try container.decode(.length)
        costInCredits = try container.decode(.costInCredits)
        crew = try container.decode(.crew)
        passengers = try container.decode(.passengers)
        maxAtmospheringSpeed = try container.decode(.maxAtmospheringSpeed)
        passengers = try container.decode(.passengers)
        hyperdriveRating = try container.decode(.hyperdriveRating)
        mglt = try container.decode(.mglt)
        cargoCapacity = try container.decode(.cargoCapacity)
        consumables = try container.decode(.consumables)
        cargoCapacity = try container.decode(.cargoCapacity)
        films = try container.decode(.films)
        pilots = try container.decode(.pilots)
        created = try container.decode(.created)
        edited = try container.decode(.edited)
    }
}

extension StarshipsModel {
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case model = "model"
        case starshipClass = "starship_class"
        case manufacturer = "manufacturer"
        case costInCredits = "cost_in_credits"
        case length = "length"
        case crew = "crew"
        case passengers = "passengers"
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case hyperdriveRating = "hyperdrive_rating"
        case mglt = "MGLT"
        case cargoCapacity = "cargo_capacity"
        case consumables = "consumables"
        case films = "films"
        case pilots = "pilots"
        case url = "url"
        case created = "created"
        case edited = "edited"
    }
}
