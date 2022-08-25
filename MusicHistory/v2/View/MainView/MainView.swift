//
//  MainView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = MainViewViewModel()
    @State var forText: String = ""
    var body: some View {
        NavigationView {
            List(vm.artists) { artist in
                NavigationLink {
                    SearchView(artist: artist)
                } label: {
                    MainCellView(artist: artist, vm: vm)
                }
            }
            .navigationTitle("Music History")
            .searchable(text: $forText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Menu("Listened") {
                            Button("Only Listened", action: {
                                
                            })
                            Button("Only Non Listened", action: {})
                            Button("Show All", action: {})
                        }
                        Menu("Low High") {
                            Button("Low To High", action: {})
                            Button("High To Low", action: {
                                vm.changeStatusInLocalJson(forArtist: 1, to: true)
                            })
                        }
                        Button("Default", action: {
                            print(vm.artists[0])
                        })
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
