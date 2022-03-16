//
//  LocalImageFileManager.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/15/22.
//

import Foundation
import SwiftUI

class LocalImageFileManager {
    
    static let instance = LocalImageFileManager()
    
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolder(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url  = getImageURL(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. Image name: \(imageName) \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getImageURL(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else
              { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolder(folderName: String) {
        
        guard let url = getFolderURL(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error Creating directory. Folder Name: \(folderName) \(error)")
            }
        }
    }
    
    private func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let url = getFolderURL(folderName: folderName) else { return nil }
        return url.appendingPathComponent(imageName + ".png")
    }
    
    private func getFolderURL(folderName: String) -> URL? {
        guard let folderURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask).first else { return nil }
        return folderURL.appendingPathComponent(folderName)
    }
}

