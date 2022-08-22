//
//  AppStorageView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/22/22.
//

import SwiftUI



struct AppStorageView: View {
    @AppStorage("name") var name = "try"
    var body: some View {
        LazyVStack {
                Text(name)
                    .frame(width: 100, height: 100)
                    .border(.cyan)
                Button("set name 1") {
                    name = "alex"
                }.buttonStyle(.borderedProminent)
                Button("set name 2") {
                    name = "mike"
                }.buttonStyle(.borderedProminent)
            
        }
    }
}

struct AppStorage_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageView()
    }
}
