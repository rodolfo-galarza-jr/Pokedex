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
                
                Spacer()
            }
        }
    }
}

struct PokemonAboutView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonAboutView(pokemon: dev.pokemon, species: dev.species)
    }
}
