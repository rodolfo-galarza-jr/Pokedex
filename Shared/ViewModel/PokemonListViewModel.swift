//
//  PokemonListViewModel.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/11/22.
//

import Foundation
import SwiftUI
import Combine

protocol PokemonListViewModelProtocol: ObservableObject {
    var pokemonList: [Pokemon] { get }
    var filteredPokemonList: [Pokemon] { get }
    var searchText: String { get set }
    var state: viewState { get }
    func getPokemonList() async
    func searchBarSubscriber()
    func filterPokemonList(searchText: String, pokemonList: [Pokemon]) -> [Pokemon]
}

final class PokemonListViewModel: ObservableObject{
    private let pokemonService: PokemonServiceProtocol
    @Published var pokemonList = [Pokemon]()
    @Published var filteredPokemonList = [Pokemon]()
    @Published var searchText:String = ""
    @Published var state: viewState = .na
    private var cancellables = Set<AnyCancellable>()
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()){
        self.pokemonService = pokemonService
        self.searchBarSubscriber()
    }
}

@MainActor
extension PokemonListViewModel: PokemonListViewModelProtocol {
    func getPokemonList() async {
        self.state = .loading
        do {
            let pokemonList = try await pokemonService.getPokemonList(forGeneration: 1)
            self.pokemonList = pokemonList
            self.filteredPokemonList = pokemonList
            self.state = .success
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
}
    
extension PokemonListViewModel {
    func searchBarSubscriber(){
        $searchText
            .receive(on: RunLoop.main)
            .map { _ in
                print(self.searchText)
                return self.filterPokemonList(searchText: self.searchText, pokemonList: self.pokemonList)
            }
            .sink{ [weak self] (filteredPokemonList) in
                self?.filteredPokemonList = filteredPokemonList
            }
            .store(in: &cancellables)
    }
    
    func filterPokemonList(searchText: String, pokemonList: [Pokemon]) -> [Pokemon] {
        guard !searchText.isEmpty else {
            return pokemonList
        }
        
        let lowerCaseSearchText = searchText.lowercased()
        return pokemonList.filter { (pokemon) -> Bool in
            return pokemon.name.lowercased().contains(lowerCaseSearchText) || "\(pokemon.id)".contains(lowerCaseSearchText)
        }
    }
}

