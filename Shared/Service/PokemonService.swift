//
//  PokemonService.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/11/22.
//

import Foundation

protocol PokemonServiceProtocol {
    func getPokemonList(forGeneration id: Int) async throws -> [Pokemon]
}

class PokemonService: PokemonServiceProtocol {
    
    func getPokemonList(forGeneration id: Int) async throws -> [Pokemon] {
        
        var pokemonList = [Pokemon]()

        let generationURL = "https://pokeapi.co/api/v2/generation/" + "\(id)"
        
        let generation = try await NetworkingManager.fetch(type: PokemonGeneration.self, url: generationURL)
        
        try await withThrowingTaskGroup(of: Pokemon.self) { group in
            for listResource in generation.pokemonSpecies {
                group.addTask {
                    let url = "https://pokeapi.co/api/v2/pokemon/" + listResource.name
                    let pokemon = try await NetworkingManager.fetch(type: Pokemon.self, url: url)
                    return pokemon
                }
            }
            
            for try await item in group {
                pokemonList.append(item)
            }
        }
        
        return pokemonList.sorted { $0.id < $1.id}
    }
}




class MockPokemonService {
    private var pokemon = [Pokemon]()

    init() {
        pokemon = [Pokemon(id: 1,
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
                                  PokemonType(id: 2, type: NamedAPIResource(name: "poison", url: "https://pokeapi.co/api/v2/type/4/"))])]
    }
}

extension MockPokemonService : PokemonServiceProtocol {
    
    func getPokemonList(forGeneration id: Int) async throws -> [Pokemon] {
        return pokemon
    }
}
