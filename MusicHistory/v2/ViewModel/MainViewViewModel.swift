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
        print("#MusicHistoryMainViewModel created")
        getArtistsFromlocaljson()
        restoreLastSort()
        searchOnMainViewPublisher()
    }
    
    // @Published private var cloudModel: CloudObject
    @Published private var localJsonModel: LocalJsonModel = LocalJsonModel()
    @Published private(set) var artists: [Artist] = [Artist]()
    @Published var mainViewSearchText = ""
    

    var cancellables = Set<AnyCancellable>()
    
    func getArtistsFromlocaljson() {
        artists = localJsonModel.getArtists()
    }
    
    func changeStatusInLocalJson(forArtist id: Int, to status: Bool) {
        localJsonModel.changeStatus(artistId: id, newStatus: status)
    }
    
    func doBackup() {
        localJsonModel.backupDataToFileManager()
    }
    
    func cleanUserData() {
        localJsonModel.clearUserData()
    }
    
    func searchOnMainViewPublisher() {
        $mainViewSearchText
            .dropFirst()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                if value == "" {
                    self.getArtistsFromlocaljson()
                    return
                } else {
                    self.getArtistsFromlocaljson()
                    self.artists = self.artists.filter { artist in
                        "\(artist.artist) \(artist.album) \(artist.id) \(artist.date)".lowercased()
                            .contains(value.lowercased())
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
            saveLastSort(how: how)
        case .onlyNonListened:
            getArtistsFromlocaljson()
            artists = artists.filter { artist in
                artist.listened == false ? true : false
            }
            saveLastSort(how: how)
        case .lowToHigh:
            getArtistsFromlocaljson()
            artists.sort { i, j in
                i.id < j.id ? true : false
            }
            saveLastSort(how: how)
        case .highToLow:
            getArtistsFromlocaljson()
            artists.sort { i, j in
                i.id > j.id ? true : false
            }
            saveLastSort(how: how)
        case .showDefault:
            getArtistsFromlocaljson()
            saveLastSort(how: how)
        }
    }
    
    func saveLastSort(how: SortVar) {
        do {
            let sortState = try JSONEncoder().encode(how)
            UserDefaults.standard.set(sortState, forKey: "last_sort")
            print("#sort state saved")
        } catch {
            print(error)
        }
    }
    
    func restoreLastSort() {
        guard let sortVarData = UserDefaults.standard.data(forKey: "last_sort") else { return }
        do {
            let sortState = try JSONDecoder().decode(SortVar.self, from: sortVarData)
            sortBy(how: sortState)
            print("#sort state restored")
        } catch {
            print(error)
        }
    }
    
    func rebase() -> Bool {
        localJsonModel.rebaseData()
    }
    
    enum SortVar: Codable {
        case onlyListened
        case onlyNonListened
        case lowToHigh
        case highToLow
        case showDefault
    }
}
