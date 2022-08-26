//
//  MainCellView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/21/22.
//

import SwiftUI

struct MainCellView: View {
    @State var artist: Artist
    @State var vm: MainViewViewModel
    var body: some View {
        HStack {
            Text("\(artist.id)")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 30, alignment: .center)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            VStack(alignment: .leading) {
                Text(artist.artist)
                    .lineLimit(2)
                    .truncationMode(.tail)
                Text(artist.album)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .font(.footnote)
            }
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
                        vm.changeStatusInLocalJson(forArtist: artist.id, to: artist.listened)
                }
            }
        }
    }
}

struct MainCellView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
//            MainCellView(artist: Artist(id: 100, artist: "David", album: "Fortune", date: 1950, listened: true))
        }
    }
}
