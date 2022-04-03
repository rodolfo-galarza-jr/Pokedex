//
//  PokemonImageView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/15/22.
//

import SwiftUI

struct PokemonImageView: View {
    
    @StateObject var vm: PokemonImageViewModel
    
    init(pokemonName: String, urlString: String) {
        _vm = StateObject(wrappedValue: PokemonImageViewModel(pokemonName: pokemonName, urlString: urlString))
    }
    
    init(pokemonName: String) {
        _vm = StateObject(wrappedValue: PokemonImageViewModel(pokemonName: pokemonName))
    }
    
    var body: some View {
        ZStack {
            switch vm.state {
            case .success:
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "questionmark")
                        .foregroundColor(Color.gray)
                }
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .task {
            await vm.getImage()
        }
    }
}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView(pokemonName: "bulbasaur", urlString: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
            .padding()
        
        
        PokemonImageView(pokemonName: "bulbasaur")
            .padding()
        
    }
}
