//
//  Evolution.swift
//  Pokedex
//
//  Created by Rodolfo Galarza Jr on 12/22/21.
//

import Foundation

struct Evolution: Codable, Identifiable {
    let id: Int
    let chain: EvolvesTo
    
}

struct EvolvesTo: Codable {
    let is_baby: Bool
    let species: NamedAPIResource
    let evolution_details: [EvolutionDetail]?
    let evolves_to: [EvolvesTo]?
}

struct Chain: Codable {
    let species: NamedAPIResource
}

struct EvolutionDetail: Codable {
    let min_level: Int?
    let trigger: NamedAPIResource
    let item: NamedAPIResource?
}
