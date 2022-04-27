//
//  PokemonTypeEffectivenessView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/17/22.
//

import SwiftUI

struct PokemonTypeEffectivenessView: View {
    let title: String
    let typeEffectivenss : [PokemonTypeEffectiveness]
    let typeColorName: String
    
    let columns: [GridItem] = [ GridItem(.adaptive(minimum: 40, maximum: 50))
                                ]
    var body: some View {
        VStack{
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(typeColorName))
                
                Spacer()
            }
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(typeEffectivenss, id: \.self) { effectiveness in
                    VStack {
                        TypeIconCircleView(typeName: effectiveness.typeName)
                        Text("x\(effectiveness.effectivenessValue.removeTrailingZeroes())")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }
            }
        }.padding()
}
}

struct PokemonTypeEffectivenessView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeEffectivenessView(title: "Weaknesses", typeEffectivenss: [
            PokemonTypeEffectiveness(typeName: "ice", effectivenessValue: 2.0),
            PokemonTypeEffectiveness(typeName: "psychic", effectivenessValue: 2.0),
            PokemonTypeEffectiveness(typeName: "flying", effectivenessValue: 2.0),
            PokemonTypeEffectiveness(typeName: "fire", effectivenessValue: 2.0)],
        typeColorName: "grass")
    }
}
