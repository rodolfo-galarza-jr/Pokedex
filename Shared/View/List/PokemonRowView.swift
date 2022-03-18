//
//  PokemonRowView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/14/22.
//

import SwiftUI

struct PokemonRowView: View {
    
    let pokemonName: String
    let pokemonImgURL: String
    let pokemonID: Int
    let types: [PokemonType]
    
    
    var body: some View {
        HStack {
            PokemonImageView(pokemonName: pokemonName, urlString: pokemonImgURL)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(pokemonName.capitalized)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: 12)
                HStack {
                    ForEach(types) { typeResource in
                        ZStack {
                            Circle()
                                .foregroundColor(Color(typeResource.type.name))
                                .frame(width: 24, height: 24)
                            
                            Image(typeResource.type.name)
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        .offset(y: -12)
                    }
                    
                    Spacer()

                    Text("#\(String(format: "%03d", pokemonID))")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.5))
                        .offset(y: 2)
                }
            }
            

        }
        .padding(.horizontal, 8)
        .padding(.vertical, -8)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(Color(types.first?.type.name ?? "Gray"))
                .opacity(0.6)
        )
    }
}

struct PokemonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRowView(pokemonName: "bulbasaur", pokemonImgURL: dev.imgURL, pokemonID: 1, types: dev.types)
            .previewLayout(.sizeThatFits)
    }
}
