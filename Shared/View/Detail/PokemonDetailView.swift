//
//  PokemonDetailView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/2/22.
//

import SwiftUI

struct PokemonDetailLoadingView: View {
    @Binding var pokemon: Pokemon?
    
    var body: some View {
        Group {
            if let pokemon = pokemon {
                PokemonDetailView(pokemon: pokemon)
            }
        }
    }
}

struct PokemonDetailView: View {
    
    @StateObject var vm: PokemonDetailViewModel
    
    init(pokemon: Pokemon) {
        _vm = StateObject(wrappedValue: PokemonDetailViewModel(pokemon: pokemon))
    }
    
    var body: some View {
        VStack{
            Text("hello")
            Text(vm.pokemon.name)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: dev.pokemon)
    }
}
