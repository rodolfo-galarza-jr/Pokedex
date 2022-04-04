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
    @State var selected = 1
    
    init(pokemon: Pokemon) {
        _vm = StateObject(wrappedValue: PokemonDetailViewModel(pokemon: pokemon))
    }
    
    var body: some View {
        VStack{
            
            PokemonImageView(pokemonName: vm.pokemon.name)
                .scaledToFit()
                .frame(maxWidth: 125, maxHeight: 125, alignment: .top)
            
            Picker(selection: $selected){
                Text("About").tag(1)
                Text("Stats").tag(2)
                Text("Evolution").tag(3)
            } label: {
                EmptyView()
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            
            switch selected {
            case 1:
                Text("About View")
            case 2:
                Text("Stats View")
            case 3:
                Text("Evolution View")
            default:
                EmptyView()
            }
            Spacer()
        }
        .task {
            await vm.getPokemonDetailData(id: vm.pokemon.id)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: dev.pokemon)
    }
}
