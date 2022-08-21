//
//  MusicHistoryMainViewModel.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation

class MusicHistoryMainViewModel: ObservableObject {
    
    init() {
        print("MusicHistoryMainViewModel created")
        getArtists()
    }
    @Published var model: ArtistModel = ArtistModel()
    @Published var artists: [Artist] = [Artist]()
    
    func getArtists() {
        artists = model.getArtists()
    }
    
    func changeListened(for id: Int, to status: Bool) {
        model.changeStatus(artistId: id, newStatus: status)
        getArtists()
    }
}
