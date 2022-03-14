//
//  PokemonListViewModel.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/11/22.
//

import Foundation

//@MainActor
protocol PokemonListViewModelProtocol: ObservableObject {
    var pokemonList: [Pokemon] { get }
    func getPokemonList() async
}

final class PokemonListViewModel: ObservableObject{
    private let pokemonService: PokemonServiceProtocol
    @Published var pokemonList = [Pokemon]()

    init(pokemonService: PokemonServiceProtocol = PokemonService()){
        self.pokemonService = pokemonService
    }
}

@MainActor
extension PokemonListViewModel: PokemonListViewModelProtocol {
    func getPokemonList() async {
        do {
            let pokemonList = try await pokemonService.getPokemonList(forGeneration: 1)
            self.pokemonList = pokemonList
        } catch {
            print(error)
        }
    }
}

