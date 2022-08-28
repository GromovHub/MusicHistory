//
//  MainView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import SwiftUI

struct MainView: View {
    // MARK: - Localizable
    let navigationTitleMain: LocalizedStringKey = "navigationTitleMain"
    let searchPromptMain: LocalizedStringKey = "searchPromptMain"
    let btnOnlyListened: LocalizedStringKey = "btnOnlyListened"
    let btnOnlyNonListened: LocalizedStringKey = "btnOnlyNonListened"
    let btnHighToLow: LocalizedStringKey = "btnHighToLow"
    let btnDefault: LocalizedStringKey = "btnDefault"
    // MARK: - View
    @StateObject private var vm = MainViewViewModel()
    @StateObject private var svm = SearchViewModel()
    @State private var sheetFlag = false
    @AppStorage("show_welcome") var showWelcome = true
    var body: some View {
        if showWelcome {
            WelcomeView()
        } else {
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
                .navigationTitle(navigationTitleMain)
                .searchable(text: $vm.mainViewSearchText, prompt: searchPromptMain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(btnOnlyListened) { vm.sortBy(how: .onlyListened) }
                            Button(btnOnlyNonListened) { vm.sortBy(how: .onlyNonListened) }
                            Button(btnHighToLow) { vm.sortBy(how: .highToLow) }
                            Button(btnDefault) { vm.sortBy(how: .showDefault) }
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            sheetFlag.toggle()
                        } label: {
                            Label("Info", systemImage: "info")
                        }
                    }
                }
            }
            .sheet(isPresented: $sheetFlag) {
                InfoView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



