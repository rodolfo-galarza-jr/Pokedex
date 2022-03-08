//
//  Species.swift
//  Pokedex
//
//  Created by Rodolfo Galarza Jr on 12/22/21.
//

import Foundation

struct Species: Identifiable, Codable {
    let id, baseHappiness, captureRate, genderRate, hatchCounter, order : Int
    let eggGroups: [NamedAPIResource]
    let growthRate, habitat: NamedAPIResource
    let evolutionChain: APIResource
    let flavorTextEntries : [flavorTextEntry]
    let hasGenderDifferences, isBaby, isLegendary, isMythical: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, order, habitat
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case genderRate = "gender_rate"
        case growthRate = "growth_rate"
        case hatchCounter = "hatch_counter"
        case eggGroups = "egg_groups"
        case evolutionChain = "evolution_chain"
        case flavorTextEntries = "flavor_text_entries"
        case hasGenderDifferences = "has_gender_differences"
        case isBaby = "is_baby"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
    }
}

struct flavorTextEntry: Codable {
    let flavorText: String
    let language: NamedAPIResource
    let version: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case language, version
        case flavorText = "flavor_text"
    }
}
