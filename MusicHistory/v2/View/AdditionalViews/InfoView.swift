//
//  InfoView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/28/22.
//

import SwiftUI

struct InfoView: View {
    // MARK: - Data
    @AppStorage("show_welcome") var showWelcome = true
    // MARK: - Localizable
    let infoTitle: LocalizedStringKey = "infoTitle"
    let supportMe: LocalizedStringKey = "supportMe"
    // MARK: - Version
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "(no version info)"
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "(no build info)"
    // MARK: - View
    var body: some View {
        VStack {
            Text(infoTitle)
                .font(.headline)
            Spacer()
            Text(supportMe)
            Link(destination: URL(string: "https://github.com/GromovHub/MusicHistory")!) {
                Image("GitHub_Logo")
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
            Group {
                Text("Version \(version)")
                Text("Build \(build)")
                Label("2022 Vitaly Gromov", systemImage: "c.circle")
            }
                .font(.caption)
                .foregroundColor(.gray)
                .onTapGesture {
                    showWelcome.toggle()
                }
        }
        .padding(.vertical)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
