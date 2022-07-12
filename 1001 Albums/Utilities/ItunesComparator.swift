//
//  ItunesComparator.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/12/22.
//

import Foundation

class ItunesComparator {
    private init() {}
    static let singleton = ItunesComparator()
    
    var classicObjects = [Classic1001Object]()
    
    func getClassicObjects(){
        guard let filePath = Bundle.main.path(forResource: "Classic1001Object", ofType: "json") else { return }
        do {
            let classicData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            classicObjects = try JSONDecoder().decode([Classic1001Object].self, from: classicData)
        } catch {
            print(error)
        }
//        print(classicObjects)
    }
    
    func getItunesJson() {
        // https://itunes.apple.com/search?entity=album&term=the+who+who's+next
        let testArray = [
            Classic1001Object(id: 235, artist: "The Bee Gees", album: "Trafalgar", date: 1971, listened: false, url: ""),
            Classic1001Object(id: 237, artist: "The Who", album: "Who's Next", date: 1971, listened: false, url: ""),
            Classic1001Object(id: 269, artist: "The Isley Bros", album: "3+3", date: 1973, listened: false, url: "")]
        for i in testArray {
            let specificArtistName: String = i.artist.replacingOccurrences(of: " ", with: "+").lowercased()
            // add album to specificArtistName
            let urlString = "https://itunes.apple.com/search?entity=album&term=\(specificArtistName)"
            print(urlString, "\n")
            guard let urlRequest = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                print(String(decoding: data!, as: UTF8.self), "\n\n\n")
                
            }.resume()
            
        }
    }
}
