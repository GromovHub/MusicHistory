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
        emptyResultsSubscriber()
        print("#SearchViewModel object is created", self.uid)
    }
    deinit {
        print("#SearchViewModel object is destroyed", self.uid)
    }
    
    @Published var searchTermValue = ""
    @Published var searchResults = [ItunesJson]()
    var cancellables = Set<AnyCancellable>()
    
    @Published var emptyResults = false
    
    func searchByTerm() async {
        //url composer
        let baseUrl = "https://itunes.apple.com/search"
        var urlComponents = URLComponents(string: baseUrl)
        let myQueryItems = [URLQueryItem(name: "term", value: searchTermValue),
                           URLQueryItem(name: "entity", value: "album"),
                           URLQueryItem(name: "limit", value: "15")]
        urlComponents?.queryItems = myQueryItems
        guard let url = urlComponents?.url else { return }
        print("#fetch url",url.description)
        // fetch
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("#data fetch +")
            let results = try JSONDecoder().decode(ItunesResult.self, from: data)
            print("#data decode +")
            Task {
                await MainActor.run { [weak self] in
                    guard let self = self else {return}
                    self.searchResults = results.results ?? [ItunesJson.shared]
                    print("#fetched data passed into searchResults", searchResults.count)
                }
            }
        } catch {
            print("#data fetch/decode error")
            print(error)
        }
    }
    
    func termSubscriber() {
        $searchTermValue
            .dropFirst()
            .sink { value in
                    print("#search to", value)
                    print("#called from sub")
                    Task {
                        await self.searchByTerm()
                    }
            }
            .store(in: &cancellables)
    }
    
    func emptyResultsSubscriber() {
        $searchResults
            .dropFirst()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { value in
                if value.isEmpty {
                    self.emptyResults = true
                } else {
                    self.emptyResults = false
                }
            }
            .store(in: &cancellables)
    }
}
