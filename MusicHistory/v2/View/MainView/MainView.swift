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
    // MARK: - ViewModel
    @StateObject private var vm = MainViewViewModel()
    @StateObject private var svm = SearchViewModel()
    // MARK: - State
    @AppStorage("main_sheet_flag") var mainSheetFlag = false
    @AppStorage("show_welcome") var showWelcome = true
    // MARK: - View
    var body: some View {
            NavigationView {
                List(vm.artists) { artist in
                    NavigationLink {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            SearchView(artist: artist, searchVM: svm)
                        }
                    } label: {
                        MainCellView(artist: artist, vm: vm)
                    }
                }
                .onAppear {
                    // clear SearchViewModel after back to MainView
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        svm.searchResults = []
                    }
                  
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
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            mainSheetFlag.toggle()
                        } label: {
                            Label("Info", systemImage: "info.circle")
                        }
                    }
                }
            }
            .sheet(isPresented: $mainSheetFlag) {
                if showWelcome {
                    WelcomeView()
                } else {
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



