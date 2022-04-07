//
//  PokemonAboutView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/4/22.
//

import SwiftUI

struct PokemonAboutView: View {
    let pokemon: Pokemon
    let species: Species?
    let typeColor: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8){
                Text(species?.flavorTextEntries.first?.flavorText.removeWhitespaceUnicode() ?? "")
                    .foregroundColor(Color(uiColor: .black).opacity(0.6))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                HStack {
                    ForEach(pokemon.types) { typeResource in
                        PokemonTypeView(type: typeResource.type.name)
                    }
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Pok\u{00E9}dex data")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(pokemon.types.first?.type.name ?? "Gray"))
                    Spacer()
                }
                .padding(8)
                
                VStack {
                    PokemonDetailDataView(dataName: "Height", dataValue: "\(pokemon.height)", typeColor: typeColor)
                    PokemonDetailDataView(dataName: "Weight", dataValue: "\(pokemon.weight)", typeColor: typeColor)
                    PokemonDetailDataView(dataName: "Habitat", dataValue: "\(species?.habitat.name ?? "")", typeColor: typeColor)
                    PokemonDetailDataView(dataName: "Gender Rate", dataValue: "\(species?.genderRate ?? 0)", typeColor: typeColor)
                    PokemonDetailDataView(dataName: "Capture Rate", dataValue: "\(species?.captureRate ?? 0)", typeColor: typeColor)
                    PokemonDetailDataView(dataName: "Growth Rate", dataValue: "\(species?.growthRate.name ?? "")", typeColor: typeColor)


                }
                
                
                
                
                
                Spacer()
            }
        }
    }
}

struct PokemonAboutView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonAboutView(pokemon: dev.pokemon, species: dev.species, typeColor: "grass")
    }
}
