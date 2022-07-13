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
// struct do decoding dirty objects
struct JsonRawObject: Codable {
    let id: Int
    var listened: String
    let artist: String
    let album: String
    let date: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "#"
        case listened = "✓"
        case artist = "Artist"
        case album = "Album Title"
        case date = "Release Date"
        case url = "URL"
    }
}
// srtruct to create comfortable objects
struct Classic1001Object: Codable {
    var id: Int
    var artist: String
    var album: String
    var date: Int
    var listened: Bool
    var url: String
    var compareProblem: Bool?
    
    init(id: Int, artist: String, album: String, date: Int, listenedString: String, url: String) {
        self.id = id
        self.artist = artist
        self.album = album
        self.date = date
        self.url = url
        self.listened = listenedString == "Yes" ? true : false
    }
    init(id: Int, artist: String, album: String, date: Int, listened: Bool, url: String) {
        self.id = id
        self.artist = artist
        self.album = album
        self.date = date
        self.url = url
        self.listened = listened
    }
}

