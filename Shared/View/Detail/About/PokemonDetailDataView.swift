//
//  PokemonDetailDataView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/6/22.
//

import SwiftUI

struct PokemonDetailDataView: View {
    let dataName: String
    let dataValue: String
    let typeColor: String
    var body: some View {
        HStack(spacing: 30) {
            Text(dataName)
                .font(.headline)
                .foregroundColor(Color(typeColor))
            
            Text(dataValue)
                .font(.headline)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct PokemonDetailDataView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailDataView(dataName: "Height", dataValue: "\(dev.pokemon.height)", typeColor: "grass")
            .previewLayout(.sizeThatFits)
    }
}
