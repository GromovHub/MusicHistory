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
