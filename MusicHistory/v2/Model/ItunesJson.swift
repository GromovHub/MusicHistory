//
//  ItunesJson.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/24/22.
//

import Foundation

struct ItunesResult: Codable {
    let resultCount: Int?
    let results: [ItunesJson]?
}

struct ItunesJson: Codable, Identifiable {
    let id: Int?
    let wrapperType: String?
    let collectionType: String?
    let artistId: Int?
    let collectionId: Int?
    let amgArtistId: Int?
    let artistName: String?
    let collectionNameString: String?
    let collectionCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let copyright: String?
    let country: String?
    let currency: String?
    let releaseDate: String?
    let primaryGenreName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case wrapperType
        case collectionType
        case artistId
        case collectionId
        case amgArtistId
        case artistName
        case collectionNameString
        case collectionCensoredName
        case artistViewUrl
        case collectionViewUrl
        case artworkUrl60
        case artworkUrl100
        case collectionPrice
        case collectionExplicitness
        case trackCount
        case copyright
        case country
        case currency
        case releaseDate
        case primaryGenreName
    }
    init(id: Int?, artistName: String?, collectionNameString: String?, collectionViewUrl: String?, artworkUrl100: String?, releaseDate: String?, wrapperType: String?, collectionType: String?, artistId: Int?, collectionId: Int?, amgArtistId: Int?, collectionCensoredName: String?, artistViewUrl: String?, artworkUrl60: String?, collectionPrice: Double?, collectionExplicitness: String?, trackCount: Int?, copyright: String?, country: String?, currency: String?, primaryGenreName: String?) {
        self.id = id
        self.wrapperType = wrapperType
        self.collectionType = collectionType
        self.artistId = artistId
        self.collectionId = collectionId
        self.amgArtistId = amgArtistId
        self.artistName = artistName
        self.collectionNameString = collectionNameString
        self.collectionCensoredName = collectionCensoredName
        self.artistViewUrl = artistViewUrl
        self.collectionViewUrl = collectionViewUrl
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.collectionPrice = collectionPrice
        self.collectionExplicitness = collectionExplicitness
        self.trackCount = trackCount
        self.copyright = copyright
        self.country = country
        self.currency = currency
        self.releaseDate = releaseDate
        self.primaryGenreName = primaryGenreName
    }
    init(from decoder: Decoder) throws {
        // set container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // set values
        self.collectionId = try container.decodeIfPresent(Int.self, forKey: .collectionId)
        /* specific key */ self.id = try container.decodeIfPresent(Int.self, forKey: .collectionId)
        self.wrapperType = try container.decodeIfPresent(String.self, forKey: .wrapperType)
        self.collectionType = try container.decodeIfPresent(String.self, forKey: .collectionType)
        self.artistId = try container.decodeIfPresent(Int.self, forKey: .artistId)
        self.amgArtistId = try container.decodeIfPresent(Int.self, forKey: .amgArtistId)
        self.artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        self.collectionNameString = try container.decodeIfPresent(String.self, forKey: .collectionNameString)
        self.collectionCensoredName = try container.decodeIfPresent(String.self, forKey: .collectionCensoredName)
        self.artistViewUrl = try container.decodeIfPresent(String.self, forKey: .artistViewUrl)
        self.collectionViewUrl = try container.decodeIfPresent(String.self, forKey: .collectionViewUrl)
        self.artworkUrl60 = try container.decodeIfPresent(String.self, forKey: .artworkUrl60)
        self.artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100)
        self.collectionPrice = try container.decodeIfPresent(Double.self, forKey: .collectionPrice)
        self.collectionExplicitness = try container.decodeIfPresent(String.self, forKey: .collectionExplicitness)
        self.trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount)
        self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName)
    }
    
    static func getTestItunesJson() -> ItunesJson {
        return ItunesJson(id: 1514, artistName: "Black Sabbath", collectionNameString: "Collapse", collectionViewUrl: "https://music.apple.com/us/album/jack-johnson-and-friends-sing-a-longs-and/1469577723?uo=4", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg", releaseDate: "2007-01-02T08:00:00Z", wrapperType: nil, collectionType: nil, artistId: nil, collectionId: nil, amgArtistId: nil, collectionCensoredName: "Paranoid", artistViewUrl: nil, artworkUrl60: nil, collectionPrice: nil, collectionExplicitness: nil, trackCount: nil, copyright: nil, country: nil, currency: nil, primaryGenreName: nil)
    }
    
    static let shared = ItunesJson(id: 1514, artistName: "Black Sabbath", collectionNameString: "Collapse", collectionViewUrl: "https://music.apple.com/us/album/jack-johnson-and-friends-sing-a-longs-and/1469577723?uo=4", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg", releaseDate: "2007-01-02T08:00:00Z", wrapperType: nil, collectionType: nil, artistId: nil, collectionId: nil, amgArtistId: nil, collectionCensoredName: "Paranoid", artistViewUrl: nil, artworkUrl60: nil, collectionPrice: nil, collectionExplicitness: nil, trackCount: nil, copyright: nil, country: nil, currency: nil, primaryGenreName: nil)
}


