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
                self?.searchResults = results.results ?? [ItunesJson.shared]
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
