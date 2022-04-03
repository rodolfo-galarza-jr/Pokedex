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
            VStack {
                
                Text("Pok\u{00E9}mon")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                
                SearchBarView(searchText: $viewModel.searchText)
                
                PokemonList
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }.task {
            await viewModel.getPokemonList()
        }
    }
}

extension PokemonListView {
    private var PokemonList: some View {
        List {
            ForEach(self.viewModel.filteredPokemonList) { pokemon in
                PokemonRowView(pokemonName: pokemon.name, pokemonImgURL: pokemon.sprites.other.official.frontDefault, pokemonID: pokemon.id, types: pokemon.types)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        
        var view = PokemonListView()
        view.viewModel = PokemonListViewModel(pokemonService: MockPokemonService())
        return view
    }
}

