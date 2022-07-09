//
//  ThousandListView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/9/22.
//

import SwiftUI

struct ThousandListView: View {
    @StateObject private var jsonVM = JSONViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(jsonVM.results) { element in
                    HStack {
                        Text("\(element.id)")
                        Spacer()
                        VStack {
                            Text(element.artist)
                                .font(.headline)
                            Text(element.albumTitle)
                        }
                        Spacer()
                        Text("\(String(element.releaseDate))")
                    }.padding()
                }
            }
            .navigationTitle("1001 Albums")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ThousandListView()
    }
}
