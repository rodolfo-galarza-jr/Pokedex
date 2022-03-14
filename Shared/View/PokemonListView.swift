//
//  PokemonListView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/12/22.
//

import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject var viewModel = PokemonListViewModel()
    
    
    var body: some View {
        NavigationView {
            List(self.viewModel.pokemonList) { pokemon in
                Text(pokemon.name.capitalized)
            }
            .navigationBarTitle("Pokemon")
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
