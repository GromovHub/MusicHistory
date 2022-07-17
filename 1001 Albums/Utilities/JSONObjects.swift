//
//  JSONObjects.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/15/22.
//

import Foundation

struct ItunesResponseObjectMain: Codable {
    var resultCount: Int
    var results: [ItunesResponseObjectResults]
}

struct ItunesResponseObjectResults: Codable {
      var wrapperType            : String
      var collectionType         : String
      var artistId               : Int
      var collectionId           : Int
      var amgArtistId            : Int?
      var artistName             : String
      var collectionName         : String
      var collectionCensoredName : String
      var artistViewUrl          : String?
      var collectionViewUrl      : String
      var artworkUrl60           : String
      var artworkUrl100          : String
      var collectionPrice        : Double?
      var collectionExplicitness : String
      var trackCount             : Int
      var copyright              : String
      var country                : String
      var currency               : String
      var releaseDate            : String
      var primaryGenreName       : String
}

struct Classic1001Object: Codable, Identifiable {
    var id: Int
    var artist: String
    var album: String
    var date: Int
    var url: [String]
    var listened: Bool
    var compareProblem: Bool
    
    init(id: Int, artist: String, album: String, date: Int, listenedString: String, url: String) {
        self.id = id
        self.artist = artist
        self.album = album
        self.date = date
        self.url = [url]
        self.listened = listenedString == "Yes" ? true : false
        self.compareProblem = false
    }
    init(id: Int, artist: String, album: String, date: Int, listened: Bool, url: String) {
        self.id = id
        self.artist = artist
        self.album = album
        self.date = date
        self.url = [url]
        self.listened = listened
        self.compareProblem = false
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case artist = "artist"
        case album = "album"
        case date = "date"
        case listened = "listened"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.album = try container.decode(String.self, forKey: .album)
        self.date = try container.decode(Int.self, forKey: .date)
        let tempUrl = try container.decode(String.self, forKey: .url)
        self.url = tempUrl == "" ? [String]() : [tempUrl]
        let tempListened = try container.decode(Bool.self, forKey: .listened)
        self.listened = tempListened == true ? true : false
        self.compareProblem = false
        // Classic1001Objects.json has not member "compareProblem"
//        let tempComapareProblem = try container.decode(Bool.self, forKey: .compareProblem)
//        self.compareProblem = tempComapareProblem == true ? true : false
    }
    enum EncodedKeys: String, CodingKey {
        case id = "id"
        case artist = "artist"
        case album = "album"
        case date = "date"
        case listened = "listened"
        case url = "url"
        case compareProblem = "compareProblem"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodedKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(artist, forKey: .artist)
        try container.encode(album, forKey: .album)
        try container.encode(date, forKey: .date)
        try container.encode(listened, forKey: .listened)
        try container.encode(compareProblem, forKey: .compareProblem)
        try container.encode(url, forKey: .url)
        
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

struct Classic1001Object2: Codable, Identifiable {
    var id: Int
    var artist: String
    var album: String
    var date: Int
    var url: [String]
    var listened: Bool
    var compareProblem: Bool
}
