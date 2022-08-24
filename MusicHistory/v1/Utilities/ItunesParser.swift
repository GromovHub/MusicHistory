//
//  ItunesParser.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/9/22.
//

import Foundation

// how to parse itunes json file

// https://itunes.apple.com/search?term=Yes+Frank+Sinatra&limit=3
// https://itunes.apple.com/search?entity=album&term=frank+sinatra
 

class SinatraParser {
    static let shared = SinatraParser()
    init(){
        getResults()
    }
    var results: Welcome? = nil
    
    struct ItunesMainLevel: Codable {
        let resultCount: Int
        let results: [ItunesResultLevel]
    }
//    struct ItunesResultLevel: Codable {
//        let wrapperType, collectionType: String
//            let artistID, collectionID, amgArtistID: Int
//            let artistName, collectionName, collectionCensoredName: String
//            let artistViewURL, collectionViewURL: String
//            let artworkUrl60, artworkUrl100: String
//            let collectionPrice: Double
//            let collectionExplicitness: String
//            let trackCount: Int
//            let copyright, country, currency: String
//            let releaseDate: Date
//            let primaryGenreName: String
//    }
    struct ItunesResultLevel: Codable {
        let collectionType: String
//        let artistID: Int
//        let collectionID: Int
//        let artistName: String
                let collectionName: String
//        let artistViewURL: String
                let collectionViewURL: String?
//            let artworkUrl100: String
//            let trackCount: Int
//            let releaseDate: Date
    }
    
    func getResults() {
        guard let filePath = Bundle.main.path(forResource: "sinatra1", ofType: "json") else {
            print("invalid file path")
            return
        }
        do {
            let fileData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            self.results = try JSONDecoder().decode(Welcome.self, from: fileData)
        } catch {
            print(error)
        }
        
    }
}

func printResults() {
    let inst = SinatraParser()
    inst.getResults()
    guard let funcWelcomeResults = inst.results else {
        print("invalid results")
        return
    }
    let funcResultsResults = funcWelcomeResults.results
    var count = 0
    for i in funcResultsResults {

        if i.collectionName.lowercased() == "In The Wee Small Hours".lowercased() {
            print("")
            print("URL FOUND")
            print(i.collectionViewURL)
            print("")
        }
        print(count, i.collectionType, i.collectionName)
        print(i.collectionViewURL)
        count += 1
    }
}


// MARK: - Welcome
struct Welcome: Codable {
    let resultCount: Int
    fileprivate let results: [ItunesResult1]
}

// MARK: - Result
fileprivate struct ItunesResult1: Codable {
    let wrapperType: WrapperType
    let collectionType: CollectionType
    let artistID, collectionID: Int
    let amgArtistID: Int?
    let artistName, collectionName, collectionCensoredName: String
    let artistViewURL, collectionViewURL: String
    let artworkUrl60, artworkUrl100: String
    let collectionPrice: Double
    let collectionExplicitness: CollectionExplicitness
    let trackCount: Int
    let copyright: String
    let country: Country
    let currency: Currency
//    let releaseDate: Date
    let primaryGenreName: String
    let contentAdvisoryRating: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case amgArtistID = "amgArtistId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, /*releaseDate,*/ primaryGenreName, contentAdvisoryRating
    }
}

enum CollectionExplicitness: String, Codable {
    case cleaned = "cleaned"
    case notExplicit = "notExplicit"
}

enum CollectionType: String, Codable {
    case album = "Album"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum WrapperType: String, Codable {
    case collection = "collection"
}
