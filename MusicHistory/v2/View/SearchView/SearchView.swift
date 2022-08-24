//
//  SearchView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/24/22.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchVM = SearchViewModel()
    var artist: Artist
    
    var body: some View {
        VStack {
                List(searchVM.searchResults) {
                    SearchCellView(jsonObject: $0)
                }
                .listStyle(.automatic)
                .navigationTitle("Itunes Search")
                .searchable(text: $searchVM.searchTerm, placement: .automatic)
                .onAppear {
                    searchVM.searchTerm = artist.artist + " " + artist.album
                }
                .task {
                    await searchVM.searchTerm()
                }
        }
       
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(artist: Artist(id: 100, artist: "Elton", album: "Super Album", date: 1970, listened: false))
    }
}
