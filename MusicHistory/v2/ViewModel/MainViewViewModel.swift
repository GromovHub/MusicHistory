//
//  MainViewViewModel.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation
import SwiftUI

final class MainViewViewModel: ObservableObject {
    
    init() {
        print("MusicHistoryMainViewModel created")
            getArtistsFromlocaljson()
    }
    @Published private var localJsonModel: LocalJsonModel = LocalJsonModel()
    // @Published private var cloudModel: CloudObject
    @Published private(set) var artists: [Artist] = [Artist]()
    
    func getArtistsFromlocaljson() {
            artists = localJsonModel.getArtists()
    }
    
    func changeStatusInLocalJson(forArtist id: Int, to status: Bool) {
            localJsonModel.changeStatus(artistId: id, newStatus: status)
            getArtistsFromlocaljson()
            print("#from MainViewViewModel#\n", artists[id - 1].self)
            if localJsonModel.allAtrists[id - 1].listened == self.artists[id - 1].listened {
                print("status changed done. date synced")
            } else {
                print("error. date non synced. index conflict")
            }
    }
    
    func sortBy(how: SortVar) {
        // перемести в модель?
        switch how {
        case .onlyListened:
            // оставь в массиве только нужные элементы
            // реверсни порядок элементов
            artists.sort { i, j in
                i.listened == true ? true : false
            }
        case .onlyNonListened:
            artists.sort { i, j in
                i.listened == true ? false : true
            }
        case .lowToHigh:
            artists.sort { i, j in
                i.id < j.id ? true : false
            }
        case .highToLow:
            artists.sort { i, j in
                i.id < j.id ? true : false
            }
        case .showDefault:
            artists = localJsonModel.getArtists()
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
