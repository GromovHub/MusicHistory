//
//  MainCellView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/21/22.
//

import SwiftUI

struct MainCellView: View {
    @State var artist: Artist
    @ObservedObject var vm: MainViewViewModel
    var body: some View {
        HStack {
            Text("\(artist.id)")
                .font(.caption)
                .foregroundColor(.secondary)
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
                    .foregroundColor(.secondary)
            }
            Spacer()
            Group {
                Text("\(String(artist.date))")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Image(systemName: artist.listened ? "circle.fill" : "circle")
                    .foregroundColor(.accentColor)
                    .frame(width: 40)
                    .background(.white)
                    .clipShape(Circle())
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
            MainCellView(artist: Artist(id: 100, artist: "David", album: "Fortune", date: 1950, listened: true), vm: MainViewViewModel())
        }
    }
}
