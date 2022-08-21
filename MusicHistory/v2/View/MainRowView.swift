//
//  MainRowView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/21/22.
//

import SwiftUI

struct MainRowView: View {
    let artist: Artist
    @ObservedObject var vm: MusicHistoryMainViewModel
    var body: some View {
        HStack {
            Text("\(artist.id)")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 40, alignment: .center)
//                .padding()
            VStack(alignment: .leading) {
                Text(artist.artist)
                Text(artist.album)
                    .font(.footnote)
            }
            Spacer()
            Group {
                Text("\(String(artist.date))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Toggle(isOn: $vm.artists[artist.id - 1].listened) {
                    Text("toggle")
                }
                .toggleStyle(ToggleStyle1())
                .frame(width: 40)
                    
            }
            .onTapGesture {
                vm.changeListened(for: 1, to: false)
                print(artist.self)
                print("hey")
            }

        }
    }
}

struct MainRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
//            MainRowView(artist: Artist(id: 1, artist: "Mike", album: "Album name", date: 1950, listened: false), listened: false, vm: MusicHistoryMainViewModel())
        }
    }
}
