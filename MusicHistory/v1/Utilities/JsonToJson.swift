//
//  JsonToJson.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/12/22.
//

import Foundation

// how to convert dirty json to comfortable json

class JsonToJson {
    // singleton pattern
    private init() {
    }
    static let singleton = JsonToJson()
    // properties to store intermediate results
    var resultsFromJsonRaw = [JsonRawObject]()
    var resultsClassic1001Object = [Classic1001Object]()
    // func with main logic
    func convert() {
        // finding path to dirty json and unwrapping
        guard let pathToRead = Bundle.main.path(forResource: "Dirty1001Object", ofType: "json") else {
            print("invalid path to read")
            return
        }
        // finding path to output directory and unwrapping
        guard let pathToWrite = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("file\(String(Int.random(in: 0...1000))).json") else {
            print("invalid path to write")
            return
        }
        do {
            // ditry json to data
            let data = try Data(contentsOf: URL(fileURLWithPath: pathToRead))
            // data to array of dirty objects
            resultsFromJsonRaw = try JSONDecoder().decode([JsonRawObject].self, from: data)
            // create array of comfortable objects
            for i in resultsFromJsonRaw {
                resultsClassic1001Object.append(Classic1001Object(id: i.id, artist: i.artist, album: i.album, date: i.date, listenedString: i.listened, url: i.url))
            }
            // write array of comfortable objects to file
            try JSONEncoder().encode(resultsClassic1001Object).write(to: pathToWrite)
        } catch {
            print(error)
        }
    }
}

