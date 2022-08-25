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
                List(searchVM.searchResults) { json in
                    SearchCellView(jsonObject: json)
                }
                .overlay {
                    if searchVM.searchResults.count == 0 {
                       VStack(alignment: .center, spacing: 10) {
                           Text("No Suggestions")
                               .font(.largeTitle)
                               .foregroundColor(.gray)
                               .opacity(0.5)
                           Text("Please check your Internet connection or change search term (pull down this text)")
                               .font(.body)
                               .foregroundColor(.gray)
                               .multilineTextAlignment(.center)
                               .opacity(0.5)
                               .frame(width: 200)
                       }
                    }
                }
                .listStyle(.automatic)
                .searchable(text: $searchVM.searchTerm, placement: .automatic)
            }
        .navigationTitle("iTunes Search")
        .onAppear {
            searchVM.searchTerm = artist.artist + " " + artist.album
        }
        .task {
            await searchVM.searchTerm()
        }
       
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(artist: Artist(id: 100, artist: "Elton", album: "Super Album", date: 1970, listened: false))
    }
}

