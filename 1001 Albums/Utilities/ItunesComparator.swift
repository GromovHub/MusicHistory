//
//  ItunesComparator.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/12/22.
//

import Foundation

class ItunesComparator {
    // singletone pattern
    private init() {}
    static let singleton = ItunesComparator()
    // properties to store results
    var classicObjects = [Classic1001Object]()
    var classicObjectsAfterLoop = [Classic1001Object]()
    var itunesResponseObjects = [ItunesResponseObjectResults]()
    
    func getClassicObjects(){
        guard let filePath = Bundle.main.path(forResource: "Classic1001Object", ofType: "json") else { print("guard invalid file path"); return }
        do {
            let classicData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            classicObjects = try JSONDecoder().decode([Classic1001Object].self, from: classicData)
        } catch {
            print("classc objects decoding error", error)
        }
//        print(classicObjects)
    }
    
    func getItunesJson() {
        getClassicObjects()
        // https://itunes.apple.com/search?entity=album&term=the+who+who's+next
        /* service */ print("Start ->", Date().description(with: .current))
        /* service */ let testArray = [
            Classic1001Object(id: 235, artist: "The Bee Gees", album: "Trafalgar", date: 1971, listened: false, url: ""),
            Classic1001Object(id: 237, artist: "The Who", album: "Who's Next", date: 1971, listened: false, url: ""),
            Classic1001Object(id: 269, artist: "The Isley Brothers", album: "3+3", date: 1973, listened: false, url: "")]
        // main loop
    mainLoop: for var i in classicObjects {
            // prepare
            let specificAlbumRequest: String = (i.artist + " " + i.album).replacingOccurrences(of: " ", with: "+").lowercased()
            let urlString = "https://itunes.apple.com/search?entity=album&term=\(specificAlbumRequest)"
        /* service */ print("this line will be requested \(i.id) -> ", urlString)
        guard let urlRequest = URL(string: urlString) else { print("guard invalid url"); writeToFile(); return }
            // request
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                /* service */ print("id: \(i.id) \(i.artist) -> task started")
//                /* service */ print(String(decoding: data!, as: UTF8.self), "\n\n\n")
                // decoding itunes data
                guard let itunesData = data else { print("guard invalid itunes data or not internet"); self.writeToFile(); return }
                do {
                    let itunesResponseObject = try JSONDecoder().decode(ItunesResponseObjectMain.self, from: itunesData)
                    /* service */ print("id: \(i.id) \(i.artist) -> itunes objects decoded")
                    /* service */ print("resultCount: \(itunesResponseObject.resultCount)")
                    if itunesResponseObject.resultCount == 0 {
                        i.compareProblem = true
                        /* service */ print("id: \(i.id) compare problem")
                        i.url = "no results"
                        self.classicObjectsAfterLoop.append(i)
                        /* service */ print("id: \(i.id) \(i.artist) -> results == 0 and append to array")
                    } else {
                        /* service */ print("id: \(i.id) \(i.artist) -> results > 0")
                        var matchesCounter = 0
                compareLoop: for j in itunesResponseObject.results {
                            /* service */ print("id: \(i.id) \(i.artist) -> compare loop started")
                        matchesCounter = 0
                        if i.artist.lowercased().contains(j.artistName.lowercased())
                            && j.collectionName.lowercased().contains(i.album.lowercased()) {
                            i.url += j.collectionViewUrl
                            // refactoring append multi url
                            i.url += " "
                            /* service */ print("some url found and appended to url property")
                            matchesCounter += 1
                        } else {
                            /* service */ print("no matches")
                        }
                        }
                        if matchesCounter != 1 {
                            i.compareProblem = true
                            /* service */ print("id: \(i.id) \(i.artist) compare problem")
                        }
                        /* service */ print("compare loop finished and object with id \(i.id) appended")
                        self.classicObjectsAfterLoop.append(i)
                    }
                } catch {
                    print("itunes data decoder error" ,error)
                }
            }
            task.resume()
            sleep(1)
        }
       /* service */ print("classic objects after loop\n", classicObjectsAfterLoop)
       /* service */ print("after loop array contains \(classicObjectsAfterLoop.count) elements")
       /* service */ print("End ->", Date().description(with: .current))
        
        
        writeToFile()
        

    }
    
    func writeToFile() {
        let fileToWrite = classicObjectsAfterLoop
        do {
            guard let pathToWrite = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("file\(String(Int.random(in: 0...1000))).json") else {
                print("invalid path to write")
                return
            }
            try JSONEncoder().encode(fileToWrite).write(to: pathToWrite)
            print("file was written to \n", pathToWrite)
        } catch {
            print(error)
        }
    }
}

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
