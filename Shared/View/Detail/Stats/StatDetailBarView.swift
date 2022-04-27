//
//  StatDetailBarView.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/10/22.
//

import SwiftUI

struct StatDetailBarView: View {
    let stat: PokemonStat
    let typeName: String
    
    var body: some View {
        HStack {
            Text(stat.statName)
                .fontWeight(.bold)
                .font(.footnote)
                .foregroundColor(.black.opacity(0.9))
                .frame(width: 60, alignment: .leading)
            
            Text("\(stat.statBase)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.black.opacity(0.8))
                .frame(width: 25)
            
            ZStack(alignment: .leading) {

                
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 150.0, height: 8.0)
                
                Capsule()
                      .fill(Color(typeName))
                      .frame(width: calculateBarWidth(statPercentage: CGFloat((Double(stat.statBase)/252.0) * 100)), height: 8.0)
            }

            
            Text("\(stat.statMin)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.black.opacity(0.8))
                .frame(width: 25)
            
            Text("\(stat.statMax)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.black.opacity(0.8))
                .frame(width: 25)
        }
    }
    
    func calculateBarWidth(statPercentage: Double) -> Double{
        return (150 * statPercentage) / 100
    }
}

struct StatDetailBarView_Previews: PreviewProvider {
    static var previews: some View {
        StatDetailBarView(stat: PokemonStat(statName: "hp", statBase: 45, statMin: 200, statMax: 294), typeName: "grass")
    }
}
