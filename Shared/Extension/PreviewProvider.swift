//
//  PreviewProvider.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/16/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.init()
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    init() {}
    
    let types = [PokemonType(id: 1, type: NamedAPIResource(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")),
                 PokemonType(id: 2, type: NamedAPIResource(name: "poison", url: "https://pokeapi.co/api/v2/type/4/"))]
    
    let imgURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
}
