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
                    Text("pay or get out")
                } label: {
                    MainRowView(artist: artist)
                }
            }
            .navigationTitle("MusicHistory")
            .searchable(text: $forText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Menu("Listened") {
                            Button("Only Listened", action: {})
                            Button("Only Non Listened", action: {})
                            Button("Show All", action: {})
                        }
                        Menu("Low High") {
                            Button("Low To High", action: {})
                            Button("High To Low", action: {})
                        }
                        Button("Default", action: {})
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
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
