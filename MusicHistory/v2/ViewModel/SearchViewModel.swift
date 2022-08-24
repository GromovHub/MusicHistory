//
//  SearchViewModel.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/24/22.
//

import Foundation
import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    var uid = UUID()
    init() {
        termSubscriber()
        print("SearchViewModel object is created", self.uid)
    }
    deinit {
        print("SearchViewModel object is destroyed", self.uid)
    }
    
    @Published var searchTerm = ""
    
    @Published var searchResults = [ItunesJson]() // remove duplicates? sort?
    var cancellables = Set<AnyCancellable>()
    
    func searchTerm() async {
        //url composer
        let baseUrl = "https://itunes.apple.com/search"
        var urlComponents = URLComponents(string: baseUrl)
        let myQueryItems = [URLQueryItem(name: "term", value: searchTerm),
                           URLQueryItem(name: "entity", value: "album"),
                           URLQueryItem(name: "limit", value: "10")]
        urlComponents?.queryItems = myQueryItems
        guard let url = urlComponents?.url else { return }
        print(url.description)
        // fetch
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            print("data fetch error")
            return }
        guard let results = try? JSONDecoder().decode(ItunesResult.self, from: data) else {
            print("data decode error")
            return }
        Task {
            await MainActor.run { [weak self] in
                self?.searchResults = results.results ?? [ItunesJson(id: 1514, artistName: "Black Sabbath", collectionNameString: "Collapse", collectionViewUrl: "https://music.apple.com/us/album/jack-johnson-and-friends-sing-a-longs-and/1469577723?uo=4", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg", releaseDate: "1950", wrapperType: nil, collectionType: nil, artistId: nil, collectionId: nil, amgArtistId: nil, collectionCensoredName: nil, artistViewUrl: nil, artworkUrl60: nil, collectionPrice: nil, collectionExplicitness: nil, trackCount: nil, copyright: nil, country: nil, currency: nil, primaryGenreName: nil)]
            }
        }
    }
    
    func termSubscriber() {
        $searchTerm
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { value in
                print("#sub", value)
                Task { [weak self] in
                    await self?.searchTerm()
                }
            }
            .store(in: &cancellables)
    }
}
