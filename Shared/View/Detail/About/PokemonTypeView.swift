//
//  PokemonTypeView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/4/22.
//

import SwiftUI

struct PokemonTypeView: View {
    let type: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color(type))
            HStack{
                Image(type)
                    .resizable()
                    .frame(width: 14, height: 14)
                Text(type.uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 4)
        }.fixedSize()
        
    }
}

struct PokemonTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeView(type: "grass")
            .previewLayout(.sizeThatFits)
    }
}
