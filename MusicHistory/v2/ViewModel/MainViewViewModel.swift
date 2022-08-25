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
    @Published private var localJsonModel: LocalJsonModel?
    // @Published private var cloudModel: CloudObject
    @Published private(set) var artists: [Artist] = [Artist]()
    
    func getArtistsFromlocaljson() {
        localJsonModel = LocalJsonModel()
        if let localJsonModel = localJsonModel {
            artists = localJsonModel.getArtists()
        } else {
            print("localJsonModel error")
        }
    }
    
    func changeStatusInLocalJson(forArtist id: Int, to status: Bool) {
        if let localJsonModel = localJsonModel {
            localJsonModel.changeStatus(artistId: id, newStatus: status)
            getArtistsFromlocaljson()
            print("#from MainViewViewModel#\n", artists[id - 1].self)
            if localJsonModel.allAtrists[id - 1].listened == self.artists[id - 1].listened {
                print("status changed done. date synced")
            } else {
                print("error. date non synced")
            }
        } else {
            print("localJsonModel error")
        }
    }
    
    
}
