//
//  PokemonImageViewModel.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/15/22.
//

import Foundation
import SwiftUI

@MainActor
class PokemonImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published private(set) var state: State = .na
    private var pokemonName: String
    private var urlString: String?
    private var folderName: String = "pokemon_images"
    private let imageFileManager = LocalImageFileManager.instance
    private let pokemonService: PokemonServiceProtocol


    
    init(pokemonName: String, urlString: String?, pokemonService: PokemonServiceProtocol = PokemonService()){
        self.pokemonName = pokemonName
        self.urlString = urlString
        self.pokemonService = pokemonService
    }
    
    init(pokemonName: String, pokemonService: PokemonServiceProtocol = PokemonService()){
        self.pokemonName = pokemonName
        self.pokemonService = pokemonService
    }
    
    func getImage() async {
        self.state = .loading
        
        if let savedImage = imageFileManager.getImage(imageName: pokemonName, folderName: folderName) {
            self.image = savedImage
            self.state = .success
        } else {
            do {
                
                guard let url = urlString else { return }
                guard let downloadedImage = try await pokemonService.getPokemonImage(url: url) else {
                    return
                }
                self.image = downloadedImage
                self.state = .success
                imageFileManager.saveImage(image: downloadedImage, imageName: pokemonName, folderName: folderName)
            } catch let error {
                print(error)
                self.state = .failed(error: error)
            }
        }
    }
}


enum State {
    case na
    case loading
    case success
    case failed(error: Error)
}

