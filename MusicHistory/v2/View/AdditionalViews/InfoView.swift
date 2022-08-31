//
//  InfoView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/28/22.
//

import SwiftUI

struct InfoView: View {
    // MARK: - State
    @AppStorage("show_welcome") var showWelcome = true
    @AppStorage("main_sheet_flag") var mainSheetFlag = false
    @ObservedObject var vm: MainViewViewModel
    @State var deleteAlertFlag = false
    @State var restartAlertFlag = false
    
    // MARK: - Localizable
    let infoTitle: LocalizedStringKey = "infoTitle"
    let supportMe: LocalizedStringKey = "supportMe"
    // MARK: - Version
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "(no version info)"
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "(no build info)"
    // MARK: - View
    var body: some View {
        VStack {
            HStack {
                Text("Close")
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        mainSheetFlag.toggle()
                    }
                Spacer()
            }
            .padding(.leading)
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
                Button("Delete My Data") {
                    deleteAlertFlag.toggle()
                    }
                .padding(.bottom)
                .buttonStyle(.borderedProminent)
                .alert("Are you sure?", isPresented: $deleteAlertFlag) {
                    Button("Delete", role: .destructive) {
                        vm.cleanUserData()
                        vm.saveLastSort(how: .showDefault)
                        restartAlertFlag.toggle()
                    }
                    Button("Cancel", role: .cancel) {}
                }
                .alert("Please restart the App", isPresented: $restartAlertFlag) {
                    Button("Ok") {
                        mainSheetFlag.toggle()
                    }
                }
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
        InfoView(vm: MainViewViewModel())
    }
}
