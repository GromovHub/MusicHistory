//
//  SearchView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/24/22.
//

import SwiftUI

struct SearchView: View {
    // MARK: - Localizable
    let navigationTitleSearch: LocalizedStringKey =  "navigationTitleSearch"
    let searchPromptSearch: LocalizedStringKey =  "searchPromptSearch"
    let noSuggestions: LocalizedStringKey =  "noSuggestions"
    let noSuggestionsHint: LocalizedStringKey =  "noSuggestionsHint"
    // MARK: - State
    var artist: Artist
    @StateObject var searchVM: SearchViewModel
    // MARK: - View
    var body: some View {
        VStack {
            List(searchVM.searchResults) { json in
                SearchCellView(jsonObject: json)
            }
            .overlay {
                if searchVM.searchResults.count == 0 {
                    noSuggestionsView
                        .transition(
                            AnyTransition.asymmetric(
                                insertion: AnyTransition.opacity.animation(Animation.default.delay(1)),
                                removal: AnyTransition.opacity)
                        )
                }
                
            }
            .listStyle(.plain)
            .searchable(text: $searchVM.searchTermValue, prompt: searchPromptSearch)
        }
        .navigationTitle(navigationTitleSearch)
        .onAppear {
            searchVM.searchTermValue = artist.artist + " " + artist.album
        }
        .task {
            searchVM.searchResults = []
            await searchVM.searchTerm()
        }
        
    }
}

// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView(artist: Artist(id: 100, artist: "Elton", album: "Super Album", date: 1970, listened: false), searchVM: SearchViewModel())
        }
    }
}

// MARK: - Components
extension SearchView {
    
    private var noSuggestionsView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
//                Spacer(minLength: UIScreen.main.bounds.height/3)
                Text(noSuggestions)
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                Text(noSuggestionsHint)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .opacity(0.5)
                    .frame(width: 200)
                Spacer()
            }
            .offset(y: 100)
        }
    }
}
