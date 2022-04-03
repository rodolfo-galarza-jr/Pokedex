//
//  PokemonListView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/16/22.
//

import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject var viewModel = PokemonListViewModel()
    
    @State private var showDetailView: Bool = false
    @State private var selectedPokemon: Pokemon? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .success:
                    VStack {
                        Text("Pok\u{00E9}mon")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.leading)
                        
                        SearchBarView(searchText: $viewModel.searchText)
                        
                        PokemonList
                    }
                case .loading:
                    ProgressView()
                default:
                    EmptyView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }.task {
            await viewModel.getPokemonList()
        }
    }
    
    private func segue(pokemon: Pokemon) {
        selectedPokemon = pokemon
        showDetailView.toggle()
    }
}

extension PokemonListView {
    private var PokemonList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(self.viewModel.filteredPokemonList) { pokemon in
                    PokemonRowView(pokemonName: pokemon.name, pokemonImgURL: pokemon.sprites.other.official.frontDefault, pokemonID: pokemon.id, types: pokemon.types)
                        .onTapGesture {
                            segue(pokemon: pokemon)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                }
                .listRowSeparator(.hidden)
            }
            .background(
                NavigationLink(
                    destination: PokemonDetailLoadingView(pokemon: $selectedPokemon),
                    isActive: $showDetailView,
                    label: {
                        EmptyView()
                    })
            )
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

