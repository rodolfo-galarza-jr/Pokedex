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
    @Published var typeStats: [PkType] = []
    
    let pokemon: Pokemon
    private let pokemonService: PokemonServiceProtocol
    private var pokemonTypeUrls: [String] = []
    
    init(pokemon: Pokemon, pokemonService: PokemonService = PokemonService()){
        self.pokemon = pokemon
        self.pokemonService = pokemonService
    }
    
    func getPokemonDetailData(id: Int) async {
        
        do {
            let species = try await pokemonService.getPokemonSpecies(id: id)
            self.species = species
            
            let evolution = try await pokemonService.getEvolution(url: species.evolutionChain.url)
            self.evolution = evolution
            
            getPokemonTypeUrls()
            
            let typeStats = try await pokemonService.getPokemonTypeStats(listOfTypes: self.pokemonTypeUrls)
            self.typeStats.append(contentsOf: typeStats)
            
        } catch {
            print(error)
        }
    }
    
    private func getPokemonTypeUrls() {
        for typeResource in pokemon.types {
            self.pokemonTypeUrls.append(typeResource.type.url)
        }
    }
}
