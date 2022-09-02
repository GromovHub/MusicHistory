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
    let landscapeHelloTitle: LocalizedStringKey = "landscapeHelloTitle"
    let landscapeHelloDescription: LocalizedStringKey = "landscapeHelloDescription"
    // MARK: - ViewModel
    @StateObject private var vm = MainViewViewModel()
    @StateObject private var svm = SearchViewModel()
    // MARK: - State
    @AppStorage("main_sheet_flag") var mainSheetFlag = true
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
                .navigationTitle(navigationTitleMain)
                .searchable(text: $vm.mainViewSearchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: searchPromptMain)
                .animation(.easeIn(duration: 1), value: vm.artists)
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
                // welcome view for lanscape mode
                landscapeHello
            }
            .sheet(isPresented: $mainSheetFlag) {
                if showWelcome {
                    WelcomeView()
                } else {
                    InfoView(vm: vm)
                }
            }
    }
}
// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// MARK: - Components
extension MainView {
    private var landscapeHello: some View {
        VStack {
            Text(landscapeHelloTitle)
                .font(.largeTitle)
            Text(landscapeHelloDescription)
                .font(.headline)
                .padding()
        }
    }
}



