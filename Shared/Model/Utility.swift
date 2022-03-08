//
//  Utility.swift
//  Pokedex
//
//  Created by Rodolfo Galarza Jr on 11/23/21.
//

import Foundation

struct APIResource : Codable {
    let url : String
}



struct NamedAPIResource: Codable, Hashable {
    let name, url : String
}



struct Description : Codable {
    let description : String
    let language : NamedAPIResource
}



struct Encounter: Codable {
    let minLevel, maxLevel, chance : Int
    let conditionValues : [NamedAPIResource]
    let method : NamedAPIResource
    
    
    enum CodingKeys : String, CodingKey {
        case chance, method
        case minLevel = "min_level"
        case maxLevel = "max_level"
        case conditionValues = "condition_values"
    }
}



struct FlavorText : Codable {
    let flavorText : String
    let language, version : NamedAPIResource
    
    enum CodingKeys : String, CodingKey {
        case language, version
        case flavorText = "flavor_text"
    }
}



struct VersionGroupDetail : Codable {
    let levelLearnedAt : Int
    let moveLearnMethod, versionGroup : NamedAPIResource
    
    enum CodingKeys : String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}



struct GenerationGameIndex : Codable {
    let gameIndex : Int
    let generation : NamedAPIResource
    
    enum CodingKeys : String, CodingKey {
        case generation
        case gameIndex = "game_index"
    }
}



struct MachineVersionDetail : Codable {
    let machine : APIResource
    let versionGroup : NamedAPIResource
    
    enum CodingKeys : String, CodingKey {
        case machine
        case versionGroup = "version_group"
    }
}



struct Name : Codable {
    let name : String
    let language : NamedAPIResource
}







