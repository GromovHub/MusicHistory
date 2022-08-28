//
//  InfoView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/28/22.
//

import SwiftUI

struct InfoView: View {
    @AppStorage("show_welcome") var showWelcome = true
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "(no version info)"
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "(no build info)"
    var body: some View {
        VStack {
            Label("Info", systemImage: "info.circle")
                .font(.headline)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.gray)
                    .opacity(0.1)
                Text("Description")
                    .font(.system(size: 50))
                    .rotationEffect(Angle(degrees: 40))
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
