//
//  MusicHistoryMainViewModel.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation

class MusicHistoryMainViewModel: ObservableObject {
    
    init() {
        artists = ArtistModel().getArtists()
        print("MusicHistoryMainViewModel created")
    }
    
    var artists: [Artist]
}
