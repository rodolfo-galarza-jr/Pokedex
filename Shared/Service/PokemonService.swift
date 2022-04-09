//
//  PokemonService.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/11/22.
//

import Foundation
import UIKit

protocol PokemonServiceProtocol {
    func getPokemonList(forGeneration id: Int) async throws -> [Pokemon]
    func getPokemonImage(url: String) async throws -> UIImage?
    func getPokemonSpecies(id: Int) async throws -> Species
    func getEvolution(url: String) async throws -> Evolution
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
    
    func getPokemonImage(url: String) async throws -> UIImage? {
        return try await NetworkingManager.fetchImage(url: url)
    }
    
    func getPokemonSpecies(id: Int) async throws -> Species {
        let url = "https://pokeapi.co/api/v2/" + "pokemon-species/\(id)"
        return try await NetworkingManager.fetch(type: Species.self, url: url)
    }
    
    func getEvolution(url: String) async throws -> Evolution {
        return try await NetworkingManager.fetch(type: Evolution.self, url: url)
    }
}

class MockPokemonService {
    private var pokemon = [Pokemon]()
    private var species: Species
    private var evolution: Evolution

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
        
        species = Species(id: 1, baseHappiness: 50, captureRate: 45, genderRate: 1, hatchCounter: 20, order: 1, eggGroups: [NamedAPIResource(name: "monster", url: "https://pokeapi.co/api/v2/egg-group/1/"), NamedAPIResource(name: "plant", url: "https://pokeapi.co/api/v2/egg-group/7/")], growthRate: NamedAPIResource(name: "medium-slow", url: "https://pokeapi.co/api/v2/growth-rate/4/"), habitat: NamedAPIResource(name: "grassland", url: "https://pokeapi.co/api/v2/pokemon-habitat/3/"), evolutionChain: APIResource(url: "https://pokeapi.co/api/v2/evolution-chain/1/"), flavorTextEntries: [flavorTextEntry(flavorText: "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokemon", language: NamedAPIResource(name: "en", url: ""), version: NamedAPIResource(name: "red", url: ""))], hasGenderDifferences: false, isBaby: false, isLegendary: false, isMythical: false)
        
        evolution = Evolution(id: 1, chain: EvolvesTo(is_baby: false, species: NamedAPIResource(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"), evolution_details: nil,
                                                      evolves_to: [EvolvesTo(is_baby: false, species: NamedAPIResource(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon-species/2/"), evolution_details: [EvolutionDetail(min_level: 16, trigger: NamedAPIResource(name: "level-up", url: "https://pokeapi.co/api/v2/evolution-trigger/1/"), item: nil)],
                                                                             evolves_to: [EvolvesTo(is_baby: false, species: NamedAPIResource(name: "venasaur", url: "https://pokeapi.co/api/v2/pokemon-species/3/"), evolution_details: [EvolutionDetail(min_level: 32, trigger: NamedAPIResource(name: "level-up", url: "https://pokeapi.co/api/v2/evolution-trigger/1/"), item: nil)], evolves_to: nil)])]))    }
}

extension MockPokemonService : PokemonServiceProtocol {
    
    func getPokemonImage(url: String) -> UIImage? {
        return UIImage(systemName: "heart.fill")
    }
    
    func getPokemonList(forGeneration id: Int) async throws -> [Pokemon] {
        return pokemon
    }
    
    func getPokemonSpecies(id: Int) async throws -> Species {
        return species
    }
    
    func getEvolution(url: String) async throws -> Evolution {
        return evolution
    }
}
