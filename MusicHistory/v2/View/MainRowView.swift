//
//  MainRowView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/21/22.
//

import SwiftUI

struct MainRowView: View {
    @State var artist: Artist
    var body: some View {
        HStack {
            Text("\(artist.id)")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 30, alignment: .center)
//                .border(.black)
            VStack(alignment: .leading) {
                Text(artist.artist)
                Text(artist.album)
                    .font(.footnote)
            }
//            .border(.black)
            Spacer()
            Group {
                Text("\(String(artist.date))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Image(systemName: artist.listened ? "circle.fill" : "circle")
                    .foregroundColor(.accentColor)
                    .frame(width: 40)
                    .onTapGesture {
                        artist.listened.toggle()
                        print(artist)
                }
            }
        }
    }
}

struct MainRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainRowView(artist: Artist(id: 100, artist: "David", album: "Fortune", date: 1950, listened: true))
        }
    }
}
