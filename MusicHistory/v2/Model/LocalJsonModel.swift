//
//  LocalJsonModel.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation
import Combine
import SwiftUI

class LocalJsonModel: ObservableObject {
    init() {
            createArtists()
        print("LocalJsonModel created")
    }
    
    private(set) var allAtrists = [Artist]()
    
    private func createArtists() {
        do {
            guard let path = Bundle.main.path(forResource: "ArtistJSON", ofType: "json") else { return }
            // data from path or from @appstorage ?
            guard let dataFromPath = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
            try allAtrists = JSONDecoder().decode([Artist].self, from: dataFromPath)
        } catch {
            print(error)
        }
    }
    
    func getArtists() -> [Artist] {
        return allAtrists
    }
    func changeStatus(artistId: Int, newStatus: Bool) {
        allAtrists[artistId - 1].listened = newStatus
        print("#from LocalJsonModel# status for artist \(artistId) changed to \(newStatus)\n", allAtrists[artistId - 1].self)
    }
}


