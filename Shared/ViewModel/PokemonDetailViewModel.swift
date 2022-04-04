//
//  PokemonDetailViewModel.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/2/22.
//

import Foundation

@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var species: Species? = nil
    @Published var evolution: Evolution? = nil
    
    let pokemon: Pokemon
    private let pokemonService: PokemonServiceProtocol
    
    init(pokemon: Pokemon, pokemonService: PokemonService = PokemonService()){
        self.pokemon = pokemon
        self.pokemonService = pokemonService
    }
    
    func getPokemonDetailData(id: Int) async {
        
        do {
            let species = try await pokemonService.getPokemonSpecies(id: id)
            print(species)
            self.species = species
            
            let evolution = try await pokemonService.getEvolution(url: species.evolutionChain.url)
            print(evolution)
            self.evolution = evolution
        } catch {
            print(error)
        }
    }
}
