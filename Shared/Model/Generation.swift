//
//  Generation.swift
//  Pokedex
//
//  Created by Rodolfo Galarza Jr on 11/24/21.
//

import Foundation

struct PokemonGeneration: Codable, Identifiable {
    let id: Int
    let name: String
    let moves: [NamedAPIResource]
    let mainRegion: NamedAPIResource
    let pokemonSpecies : [NamedAPIResource]
    let types: [NamedAPIResource]
    let versionGroups : [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, name, moves, types
        case mainRegion = "main_region"
        case pokemonSpecies = "pokemon_species"
        case versionGroups = "version_groups"
    }
}
