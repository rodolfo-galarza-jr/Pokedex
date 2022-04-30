//
//  PokemonStatsViewModel.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/9/22.
//

import Foundation

class PokemonStatsViewModel: ObservableObject {
    @Published var pokemonStats: [PokemonStat] = []
    @Published var totalStatValue: Int = 0
    @Published var typeStatsDict = [String : Double]()
    @Published var resistances = [PokemonTypeEffectiveness]()
    @Published var weaknesses = [PokemonTypeEffectiveness]()
    private let statsResources: [Stat]
    private let typeStats: [PkType]
    private let maxStatNature: Double = 1.1
    private let maxStatEV: Int = 252
    private let maxStatIV: Int = 31
    private let minStatNature: Double = 0.9
    private let minStatEV: Int = 0
    private let minStatIV: Int = 0
    private let level: Int = 100
    private let statTypes = [ "hp" : "HP",
                                      "attack" : "ATK",
                                      "defense": "DEF",
                                      "special-attack": "SP. ATK",
                                      "special-defense": "SP. DEF",
                                      "speed" : "SPD"]
    
    
    init(statsResources: [Stat], typeStats: [PkType]){
        self.statsResources = statsResources
        self.typeStats = typeStats
        calculatePokemonStats()
        processTypes()
    }
    
    func processTypes() {
        for type in typeStats {
            processTypeDoubleDamage(doubleDamageTypes: type.damageRelations.doubleDamageFrom)
            processTypeHalfDamage(halfDamageTypes: type.damageRelations.halfDamageFrom)
            processTypeNoDamage(noDamageTypes: type.damageRelations.noDamageFrom)
        }
                
        let resistances = typeStatsDict.filter { key, value in
            return value < 1.0 && value != 0.0
        }
        
        for (key, value) in resistances {
            self.resistances.append(PokemonTypeEffectiveness(typeName: key, effectivenessValue: value))
        }
        
        let weaknesses = typeStatsDict.filter{ key, value in
            return value > 1.0
        }
        
        for (key, value) in weaknesses {
            self.weaknesses.append(PokemonTypeEffectiveness(typeName: key, effectivenessValue: value))
        }

    }
    
    func processTypeDoubleDamage(doubleDamageTypes: [NamedAPIResource]){
        for type in doubleDamageTypes {
            if typeStatsDict.contains(where: { $0.key == type.name }) {
                if let effectiveness = typeStatsDict[type.name] {
                    typeStatsDict[type.name] = effectiveness * 2
                }
            } else {
                typeStatsDict[type.name] = 2.0
            }
        }
    }
    
    func processTypeHalfDamage(halfDamageTypes: [NamedAPIResource]){
        for type in halfDamageTypes {
            if typeStatsDict.contains(where: { $0.key == type.name }){
                if let effectiveness = typeStatsDict[type.name] {
                    typeStatsDict[type.name] = effectiveness * 0.5
                }
            } else {
                typeStatsDict[type.name] = 0.5
            }
        }
    }
    
    func processTypeNoDamage(noDamageTypes: [NamedAPIResource]) {
        for type in noDamageTypes {
            if typeStatsDict.contains(where: { $0.key == type.name }) {
                if let effectiveness = typeStatsDict[type.name] {
                    typeStatsDict[type.name] = effectiveness * 0
                }
            } else {
                typeStatsDict[type.name] = 0
            }
        }
    }
    
    func calculatePokemonStats(){
        
        for statResource in statsResources {
            totalStatValue += statResource.baseStat
            pokemonStats.append(PokemonStat(statName: statTypes[statResource.stat.name] ?? statResource.stat.name,
                                            statBase: statResource.baseStat,
                                            statMin: calculateStatMin(baseStat: statResource.baseStat, name: statResource.stat.name),
                                            statMax: calculateStatMax(baseStat: statResource.baseStat, name: statResource.stat.name)))
        }
    }
    
    func calculateStatMin(baseStat: Int, name: String) -> Int {
        if name == "hp" {
            return (baseStat*2) + minStatIV + minStatEV/4 + level + 10
        } else {
            let minStatValue = Double(((baseStat*2) + minStatIV + (minStatEV/4)) + 5) * minStatNature
            return Int(minStatValue)
        }
    }

    func calculateStatMax(baseStat: Int, name: String) -> Int {
        if name == "hp" {
            return (baseStat*2) + maxStatIV + maxStatEV/4 + level + 10
        } else {
            let maxStatValue = Double(((baseStat*2) + maxStatIV + (maxStatEV/4)) + 5) * maxStatNature
            return Int(maxStatValue)
        }
    }
}


struct PokemonStat {
    let statName: String
    let statBase: Int
    let statMin: Int
    let statMax: Int
}

struct PokemonTypeEffectiveness: Hashable {
    let typeName: String
    let effectivenessValue: Double
}
