//
//  Type.swift
//  Pokedex
//
//  Created by Rodolfo Galarza Jr on 1/15/22.
//

import Foundation

struct PkType: Codable, Identifiable {
    let id: Int
    let name: String
    let damageRelations: damageRelations
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case damageRelations    =   "damage_relations"
    }
}



struct damageRelations: Codable {
    let doubleDamageFrom, doubleDamageTo, halfDamageFrom, halfDamageTo, noDamageFrom, noDamageTo: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case doubleDamageFrom   =   "double_damage_from"
        case doubleDamageTo     =   "double_damage_to"
        case halfDamageFrom     =   "half_damage_from"
        case halfDamageTo       =   "half_damage_to"
        case noDamageFrom       =   "no_damage_from"
        case noDamageTo         =   "no_damage_to"
    }
}
