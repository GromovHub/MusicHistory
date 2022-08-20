//
//  MusicHistoryMainView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import SwiftUI

struct MusicHistoryMainView: View {
    @StateObject private var vm = MusicHistoryMainViewModel()
    var body: some View {
        NavigationView {
            List(vm.artists) {
                Text($0.artist)
            }
            .navigationTitle("MusicHistory")
        }
        
    }
}

struct MusicHistoryMainView_Previews: PreviewProvider {
    static var previews: some View {
        MusicHistoryMainView()
    }
}
