//
//  PokemonDetailModel.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import Foundation

struct PokemonDetailModel: Codable {
    var baseExperience: Int
    var height: Int
    var id: Int
    var isDefault: Bool
    var locationAreaEncounters: String
    var name: String
    var order: Int
    var sprites: Sprites
    var weight: Int
    
    fileprivate enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case name, order
        case sprites
        case weight
    }
    
    init(baseExperience: Int, height: Int, id: Int, isDefault: Bool, locationAreaEncounters: String,
         name: String, order: Int, sprites: Sprites, weight: Int) {
        
        self.baseExperience = baseExperience
        self.height = height
        self.id = id
        self.isDefault = isDefault
        self.locationAreaEncounters = locationAreaEncounters
        self.name = name
        self.order = order
        self.sprites = sprites
        self.weight = weight
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.baseExperience = try container.decode(Int.self, forKey: .baseExperience)
        self.height = try container.decode(Int.self, forKey: .height)
        self.id = try container.decode(Int.self, forKey: .id)
        self.isDefault = try container.decode(Bool.self, forKey: .isDefault)
        self.locationAreaEncounters = try container.decode(String.self, forKey: .locationAreaEncounters)
        self.name = try container.decode(String.self, forKey: .name)
        self.order = try container.decode(Int.self, forKey: .order)
        self.sprites = try container.decode(Sprites.self, forKey: .sprites)
        self.weight = try container.decode(Int.self, forKey: .weight)
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String
    let backShiny: String
    let frontDefault: String
    let frontShiny: String

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    init(backDefault: String, backShiny: String, frontDefault: String, frontShiny: String) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}
