//
//  PokemonStatsView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/8/22.
//

import SwiftUI

struct PokemonStatsView: View {
    
    @StateObject var vm: PokemonStatsViewModel
    let typeName: String
    
    init(stats: [Stat], typeName: String, typeStats: [PkType]){
        self.typeName = typeName
        _vm = StateObject(wrappedValue: PokemonStatsViewModel(statsResources: stats, typeStats: typeStats))
    }
    
    var body: some View {
        
        
        ScrollView {
            VStack(alignment: .center){
                HStack{
                    Text("Base Stats")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(typeName))
                    Spacer()
                }.padding(.horizontal)
                
                
                // MARK: Stats Bar Stats
                ForEach(vm.pokemonStats, id: \.self.statName) { stat in
                    StatDetailBarView(stat: stat, typeName: typeName)
                        .padding(.vertical, 2)
                }
                
                //MARK: Total Stats Row
                HStack {
                    Text("Total")
                        .fontWeight(.bold)
                        .font(.footnote)
                        .frame(width: 60, alignment: .leading)
                    
                    Text("\(vm.totalStatValue)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(width: 25)
                    
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 150.0, height: 8.0)

                    Text("Min")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(width: 25)
                    
                    Text("Max")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(width: 25)
                }.padding(.vertical, 2)
                
                PokemonTypeEffectivenessView(title: "Weak Against", typeEffectivenss: vm.weaknesses, typeColorName: typeName)
                PokemonTypeEffectivenessView(title: "Strong Against", typeEffectivenss: vm.resistances, typeColorName: typeName)
            }
        }
    }
}

struct PokemonStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonStatsView(stats: dev.pokemon.stats, typeName: "grass", typeStats: [dev.typeStat])
    }
}
