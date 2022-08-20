//
//  ClassicToArtist.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation

class ClassicToArtist {
    var allClassic = [Classic1001Object2]()
    var allAtrist = [Artist]()
    
    func jsonToClassic() {
        do {
            guard let path = Bundle.main.path(forResource: "Classic1001ObjectAfterLoop2", ofType: "json") else { return }
            guard let dataFromPath = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
            allClassic = try JSONDecoder().decode([Classic1001Object2].self, from: dataFromPath)
            print(allClassic)
        } catch {
            print(error)
        }
    }
    
    func classicToArtist() {
        for i in allClassic {
            allAtrist.append(Artist(id: i.id, artist: i.artist, album: i.album, date: i.date, listened: i.listened))
            print(i.id, "added")
        }
        
    }
    
    func wtiteArtistToFile() {
        let directoryToSave = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let pathToSave = directoryToSave?.appendingPathComponent("file\(String(Int.random(in: 0...1000))).json")
        do {
            let dataToWrite = try JSONEncoder().encode(allAtrist)
            print(String(decoding: dataToWrite, as: UTF8.self))
            try dataToWrite.write(to: pathToSave!)
            print(pathToSave!)
            
        } catch {
            print("encode failed \n",error)
        }
    }
    
}
