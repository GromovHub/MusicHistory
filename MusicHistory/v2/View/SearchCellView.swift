//
//  SearchCellView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/24/22.
//

import SwiftUI

struct SearchCellView: View {
    var jsonObject: ItunesJson
    var body: some View {
        HStack() {
            AsyncImage(url: URL(string: jsonObject.artworkUrl100!)!) {
                $0
                .border(.gray)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: 100, height: 100, alignment: .center)
            }
            VStack(alignment: .leading) {
                Text(jsonObject.collectionCensoredName ?? "error")
                    .font(.body)
                    .fontWeight(.regular)
                    .lineLimit(2)
                Text(jsonObject.artistName ?? "error")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text(jsonObject.releaseDate ?? "error")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            Spacer(minLength: 20)
            Link(destination: URL(string: jsonObject.collectionViewUrl!)!) {
                Image(systemName: "link")
            }.buttonStyle(.borderedProminent)

        }
    }
}

struct SearchCellView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellView(jsonObject: ItunesJson(id: 1514, artistName: "Black Sabbath", collectionNameString: "Paranoid", collectionViewUrl: "https://music.apple.com/us/album/jack-johnson-and-friends-sing-a-longs-and/1469577723?uo=4", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg", releaseDate: "1950", wrapperType: nil, collectionType: nil, artistId: nil, collectionId: nil, amgArtistId: nil, collectionCensoredName: nil, artistViewUrl: nil, artworkUrl60: nil, collectionPrice: nil, collectionExplicitness: nil, trackCount: nil, copyright: nil, country: nil, currency: nil, primaryGenreName: nil))
    }
}
