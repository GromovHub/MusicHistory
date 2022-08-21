//
//  MusicHistoryMainView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import SwiftUI

struct MusicHistoryMainView: View {
    @StateObject private var vm = MusicHistoryMainViewModel()
    @State var forText: String = ""
    var body: some View {
        NavigationView {
            List(vm.artists) { artist in
                NavigationLink {
                    //dest
                    ProgressView()
                    Text("плати деньги чмо")
                } label: {
                    MainRowView(artist: artist, vm: vm)
                }
            }
            .navigationTitle("MusicHistory")
            .searchable(text: $forText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // show sheet with sort actions
                    Text("Filter")
                        .foregroundColor(.accentColor)
                }
            }
        }
        
    }
}

struct MusicHistoryMainView_Previews: PreviewProvider {
    static var previews: some View {
        MusicHistoryMainView()
    }
}
