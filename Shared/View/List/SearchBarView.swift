//
//  SearchBarView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/17/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.gray : Color.black)
            
            TextField("Search by name or id", text: $searchText)
                .font(.headline)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }, alignment: .trailing
                )
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 18)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.25))
                .shadow(color: Color.red.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
