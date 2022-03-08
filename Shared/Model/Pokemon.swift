//
//  Pokemon.swift
//  Pokedex
//
//  Created by Rodolfo Galarza Jr on 11/23/21.
//

import Foundation

struct Pokemon : Identifiable, Codable {
    let id, height, weight, baseExperience : Int
    let name : String
    let isDefault : Bool
    let abilities : [Ability]
    let locationAreaEncounters : String
    let moves : [Move]
    let species : NamedAPIResource
    let sprites : Sprites
    let stats : [Stat]
    let types : [PokemonType]
    
    enum CodingKeys : String, CodingKey {
        case id, height, weight, name, abilities, moves, species, sprites, stats, types
        case baseExperience = "base_experience"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
    }
    
}



struct Ability : Identifiable, Codable {
    let id : Int
    let isHidden : Bool
    let ability : NamedAPIResource
    
    enum CodingKeys : String, CodingKey {
        case ability
        case id = "slot"
        case isHidden = "is_hidden"
    }
}



struct Move : Codable {
    let move : NamedAPIResource
    let versionGroupDetails : [VersionGroupDetail]
    
    enum CodingKeys : String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}



struct Sprites: Codable{
    let other: other
    
    struct other: Codable{
        let dream: dreamWorld
        let official: officialArtwork
        
        enum CodingKeys: String, CodingKey {
            case dream = "dream_world"
            case official = "official-artwork"
        }
        
        struct dreamWorld: Codable{
            let frontDefault: String?
            let frontFemale: String?
    
            enum CodingKeys: String, CodingKey {
                case frontDefault = "front_default"
                case frontFemale  = "front_female"
            }
        }
        
        struct officialArtwork: Codable {
            let frontDefault: String
            
            enum CodingKeys: String, CodingKey {
                case frontDefault = "front_default"
            }
        }
    }
}



struct Stat : Codable, Hashable {
    
    let baseStat, effort : Int
    let stat : NamedAPIResource
    
    enum CodingKeys : String, CodingKey {
        case effort, stat
        case baseStat = "base_stat"
    }
}



struct PokemonType : Codable, Identifiable {
    let id : Int
    let type : NamedAPIResource
    
    enum CodingKeys : String, CodingKey {
        case type
        case id = "slot"
    }
}




