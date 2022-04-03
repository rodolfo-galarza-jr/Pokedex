//
//  PokemonDetailViewModel.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/2/22.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    let pokemon: Pokemon
    
    init(pokemon: Pokemon){
        self.pokemon = pokemon
    }
}
