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
        print("LocalJsonModel created")
            createArtists()
    }
    
    private(set) var allAtrists = [Artist]()
    private var allArtistsData = Data()
    
    private func createArtists() {
        if let artistArrayData = UserDefaults.standard.data(forKey: "user_listened") {
            do {
                let data = try JSONDecoder().decode([Artist].self, from: artistArrayData)
                allAtrists = data
                print("data restored from user defaults")
            } catch {
                print("user defaults data error\n", error)
                // create data from local json
                    guard let path = Bundle.main.path(forResource: "ArtistJSON", ofType: "json") else { return }
                    guard let dataFromPath = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
                    guard let data = try? JSONDecoder().decode([Artist].self, from: dataFromPath) else { return }
                    allAtrists = data
                    print("data passed from local path ")
                
            }
        } else {
            // create data from local json
                guard let path = Bundle.main.path(forResource: "ArtistJSON", ofType: "json") else { return }
                guard let dataFromPath = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
                guard let data = try? JSONDecoder().decode([Artist].self, from: dataFromPath) else { return }
                allAtrists = data
                print("data passed from local path ")
        }
    }
    
    func getArtists() -> [Artist] {
        return allAtrists
    }
    
    func changeStatus(artistId: Int, newStatus: Bool) {
        // change status
        var artistIndex: Int = 0
        allAtrists.indices.forEach { if (allAtrists[$0].id == artistId) { artistIndex = $0 } }
        allAtrists[artistIndex].listened = newStatus
        print("#from LocalJsonModel# status for artist \(artistId) changed to \(newStatus)\n", allAtrists[artistIndex].self)
       // save new data
        do {
            let data = try JSONEncoder().encode(allAtrists)
            UserDefaults.standard.set(data, forKey: "user_listened")
            print("data saved to user defaults")
        } catch {
            print(error)
        }
        
    }
    
    func backupDataToFileManager() {
        let directoryToSave = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let pathToSave = directoryToSave?.appendingPathComponent("MusicHistoryBackup.json")
            do {
                let dataToWrite = try JSONEncoder().encode(allAtrists)
                try dataToWrite.write(to: pathToSave!)
                print(pathToSave?.description ?? "invalid path")
                
            } catch {
                print("backup failed \n",error)
            }
    }
    
    func clearUserData() {
        UserDefaults.standard.set(Data(), forKey: "user_listened")
        print("user data erased")
    }
}


