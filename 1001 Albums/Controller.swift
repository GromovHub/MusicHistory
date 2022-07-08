//
//  Controller.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/8/22.
//

import Foundation

class Controller {
    init() {
        createArray()
    }
  
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                print(fileUrl)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }


    func printJSON() {
        let x = readLocalJSONFile(forName: "json1001raw")
        guard let data = x else {
            print("guard error")
            return
        }
        print(String(decoding: data, as: UTF8.self))
    }
    
    func createArray() {
        let dataRaw: Data? = readLocalJSONFile(forName: "json1001raw")
        guard let dataClear = dataRaw else {
            print("guard error")
            return
        }
//        print(String(decoding: dataClear, as: UTF8.self))
        var array = [JSON1001]()
        do {
            let obj = try JSONDecoder().decode([JSON1001].self, from: dataClear)
            array = obj
        } catch {
            print("JSONDecoder error")
        }
//        print(array)
        var counter = 1
        for i in array {
            print(counter, i.Artist)
            counter += 1
        }
    }
    
}

struct JSON1001: Codable {
    let Artist: String
}
