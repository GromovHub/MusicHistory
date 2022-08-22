//
//  UserDefaultsView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/22/22.
//

import SwiftUI

struct UserDefaultsView: View {
    @State var name = "try"
//    @State var name = UserDefaults.standard.string(forKey: "mainname")!
    var body: some View {
        VStack(spacing: 20) {
            Text(name)
                .frame(width: 100, height: 100)
                .background(.bar)
            Button("set name 1") {
                name = "alex"
            }.buttonStyle(.borderedProminent)
            Button("set name 2") {
                name = "john"
            }.buttonStyle(.borderedProminent)
            Button("save") {
                UserDefaults.standard.set(name, forKey: "mainname")
            }.buttonStyle(.borderedProminent)
            Button("restore") {
                if let oldName = UserDefaults.standard.string(forKey: "mainname") {
                    name = oldName
                } else {
                    name = "error"
                }
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct UserDefaults_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsView()
    }
}
