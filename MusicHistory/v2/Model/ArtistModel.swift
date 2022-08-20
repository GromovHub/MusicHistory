//
//  ArtistModel.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation

class ArtistModel {
    init() {
        createArtists()
        print("ArtistModel created")
    }
    
    private var allAtrists = [Artist]()
    
    private func createArtists() {
        do {
            guard let path = Bundle.main.path(forResource: "ArtistJSON", ofType: "json") else { return }
            guard let dataFromPath = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
            try allAtrists = JSONDecoder().decode([Artist].self, from: dataFromPath)
        } catch {
            print(error)
        }
    }
    
    func getArtists() -> [Artist] {
        return allAtrists
    }
}
