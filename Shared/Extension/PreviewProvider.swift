//
//  PreviewProvider.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/16/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.init()
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    init() {}
    
    let types = [PokemonType(id: 1, type: NamedAPIResource(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")),
                 PokemonType(id: 2, type: NamedAPIResource(name: "poison", url: "https://pokeapi.co/api/v2/type/4/"))]
    
    let imgURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
    
    let pokemon = Pokemon(id: 1,
                          height: 7,
                          weight: 69,
                          baseExperience: 64,
                          name: "bulbasaur",
                          isDefault: true,
                          abilities:
                            [Ability(id: 1, isHidden: false, ability: NamedAPIResource(name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/")), Ability(id: 3, isHidden: true, ability: NamedAPIResource(name: "chlorophyll", url: "https://pokeapi.co/api/v2/ability/34/"))],
                          locationAreaEncounters:
                            "https://pokeapi.co/api/v2/pokemon/1/encounters",
                          moves:
                                    [Move(move: NamedAPIResource(name: "razor-wind", url: "https://pokeapi.co/api/v2/move/13/"), versionGroupDetails: [VersionGroupDetail(
                                            levelLearnedAt: 0,
                                            moveLearnMethod: NamedAPIResource(name: "egg", url: "https://pokeapi.co/api/v2/move-learn-method/2/"),
                                            versionGroup: NamedAPIResource(name: "crystal", url: "https://pokeapi.co/api/v2/version-group/4/"))])],
                          species:
                                    NamedAPIResource(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
                          sprites:
                                    Sprites(other: Sprites.other(dream: Sprites.other.dreamWorld(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg", frontFemale: nil), official: Sprites.other.officialArtwork(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"))),
                          stats: [
                                    Stat(baseStat: 45, effort: 0, stat: NamedAPIResource(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")),
                                    Stat(baseStat: 49, effort: 0, stat: NamedAPIResource(name: "attack", url: "https://pokeapi.co/api/v2/stat/2/")),
                                    Stat(baseStat: 49, effort: 0, stat: NamedAPIResource(name: "defence", url: "https://pokeapi.co/api/v2/stat/3/")),
                                    Stat(baseStat: 65, effort: 1, stat: NamedAPIResource(name: "special-attack", url: "https://pokeapi.co/api/v2/stat/4/")),
                                    Stat(baseStat: 65, effort: 0, stat: NamedAPIResource(name: "special-defence", url: "https://pokeapi.co/api/v2/stat/5/")),
                                    Stat(baseStat: 45, effort: 0, stat: NamedAPIResource(name: "speed", url: "https://pokeapi.co/api/v2/stat/6/"))
                          ],
                          types: [PokemonType(id: 1, type: NamedAPIResource(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")),
                                 PokemonType(id: 2, type: NamedAPIResource(name: "poison", url: "https://pokeapi.co/api/v2/type/4/"))])
    
    let species =  Species(id: 1, baseHappiness: 50, captureRate: 45, genderRate: 1, hatchCounter: 20, order: 1, eggGroups: [NamedAPIResource(name: "monster", url: "https://pokeapi.co/api/v2/egg-group/1/"), NamedAPIResource(name: "plant", url: "https://pokeapi.co/api/v2/egg-group/7/")], growthRate: NamedAPIResource(name: "medium-slow", url: "https://pokeapi.co/api/v2/growth-rate/4/"), habitat: NamedAPIResource(name: "grassland", url: "https://pokeapi.co/api/v2/pokemon-habitat/3/"), evolutionChain: APIResource(url: "https://pokeapi.co/api/v2/evolution-chain/1/"), flavorTextEntries: [flavorTextEntry(flavorText: "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokemon", language: NamedAPIResource(name: "en", url: ""), version: NamedAPIResource(name: "red", url: ""))], hasGenderDifferences: false, isBaby: false, isLegendary: false, isMythical: false)
}
