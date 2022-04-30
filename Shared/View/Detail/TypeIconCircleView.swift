//
//  TypeIconCircleView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/17/22.
//

import SwiftUI

struct TypeIconCircleView: View {
    let typeName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(typeName))
                .frame(width: 24, height: 24)
            
            Image(typeName)
                .resizable()
                .frame(width: 16, height: 16)
        }
    }
}

struct TypeIconCircleView_Previews: PreviewProvider {
    static var previews: some View {
        TypeIconCircleView(typeName: "grass")
            .previewLayout(.sizeThatFits)
    }
}
