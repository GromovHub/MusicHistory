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
    let btnFilter: LocalizedStringKey = "btnFilter"
    // MARK: - View
    @StateObject private var vm = MainViewViewModel()
    @StateObject private var svm = SearchViewModel()
    
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
                            Text(btnFilter)
                                .foregroundColor(.accentColor)
//                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            vm.showInfo.toggle()
                        } label: {
                            Label("Info", systemImage: "info.circle")
                        }
                    }
                }
            }
            .sheet(isPresented: $vm.showWelcome) {
                WelcomeView()
            }
            .sheet(isPresented: $vm.showInfo) {
                InfoView()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



