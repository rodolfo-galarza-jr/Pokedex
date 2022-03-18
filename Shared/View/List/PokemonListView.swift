//
//  PokemonListView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/16/22.
//

import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject var viewModel = PokemonListViewModel()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.pokemonList) { pokemon in
                    PokemonRowView(pokemonName: pokemon.name, pokemonImgURL: pokemon.sprites.other.official.frontDefault, pokemonID: pokemon.id, types: pokemon.types)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }.task {
            await viewModel.getPokemonList()
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        
        var view = PokemonListView()
        view.viewModel = PokemonListViewModel(pokemonService: MockPokemonService())
        return view
    }
}

