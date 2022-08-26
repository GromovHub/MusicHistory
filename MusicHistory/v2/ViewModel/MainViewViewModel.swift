//
//  MainViewViewModel.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation
import SwiftUI
import Combine

final class MainViewViewModel: ObservableObject {
    
    init() {
        print("MusicHistoryMainViewModel created")
            getArtistsFromlocaljson()
        searchOnMainViewPublisher()
    }
    @Published private var localJsonModel: LocalJsonModel = LocalJsonModel()
    // @Published private var cloudModel: CloudObject
    @Published private(set) var artists: [Artist] = [Artist]()
    @Published var mainViewSearchText = ""
    var cancellables = Set<AnyCancellable>()
    
    func getArtistsFromlocaljson() {
            artists = localJsonModel.getArtists()
    }
    
    func changeStatusInLocalJson(forArtist id: Int, to status: Bool) {
            localJsonModel.changeStatus(artistId: id, newStatus: status)
//            getArtistsFromlocaljson()
    }
    
    func searchOnMainViewPublisher() {
        $mainViewSearchText
            .dropFirst()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { value in
                if value == "" {
                    self.getArtistsFromlocaljson()
                    return
                } else {
                    self.artists = self.artists.filter { artist in
                        (artist.artist + " " + artist.album)
                            .contains(value)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func sortBy(how: SortVar) {
        switch how {
        case .onlyListened:
            getArtistsFromlocaljson()
            artists = artists.filter { artist in
                artist.listened ? true : false
            }
        case .onlyNonListened:
            getArtistsFromlocaljson()
            artists = artists.filter { artist in
                artist.listened == false ? true : false
            }
        case .lowToHigh:
            getArtistsFromlocaljson()
            artists.sort { i, j in
                i.id < j.id ? true : false
            }
        case .highToLow:
            getArtistsFromlocaljson()
            artists.sort { i, j in
                i.id > j.id ? true : false
            }
        case .showDefault:
            getArtistsFromlocaljson()
        }
    }
    enum SortVar {
        case onlyListened
        case onlyNonListened
        case lowToHigh
        case highToLow
        case showDefault
    }
}
