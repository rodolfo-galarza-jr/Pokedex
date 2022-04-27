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
                PokemonAboutView(pokemon: vm.pokemon, species: vm.species, typeColor: (vm.pokemon.types.first?.type.name ?? "normal"))
            case 2:
                PokemonStatsView(stats: vm.pokemon.stats, typeName: (vm.pokemon.types.first?.type.name ?? "normal"), typeStats: vm.typeStats)
            case 3:
                Text("Evolution View")
            default:
                EmptyView()
            }
            Spacer()
        }
        .onAppear(perform: {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(vm.pokemon.types.first?.type.name ?? "normal"))
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        })
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
