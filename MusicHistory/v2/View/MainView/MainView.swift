//
//  MainView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = MainViewViewModel()
    @StateObject private var svm = SearchViewModel()
    @State var forText: String = ""
    var body: some View {
        NavigationView {
            List(vm.artists) { artist in
                NavigationLink {
                    SearchView(artist: artist, searchVM: svm)
                } label: {
                    MainCellView(artist: artist, vm: vm)
                }
            }
            .onAppear {
                // clear SearchViewModel after back to MainView
                svm.searchResults = []
            }
            .navigationTitle("Music History")
            .searchable(text: $vm.mainViewSearchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Only Listened") { vm.sortBy(how: .onlyListened) }
                        Button("Only Non Listened") { vm.sortBy(how: .onlyNonListened) }
                        Button("High To Low") { vm.sortBy(how: .highToLow) }
                        Button("Default") { vm.sortBy(how: .showDefault) }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
