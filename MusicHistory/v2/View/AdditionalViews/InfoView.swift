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
    @AppStorage("main_sheet_flag") var mainSheetFlag = true
    @ObservedObject var vm: MainViewViewModel
    @State var deleteAlertFlag = false
    @State var restartAlertFlag = false
    @State var rebaseFlag = false
    @State var rebaseAlertFlag = false
    // MARK: - Localizable
    let infoTitle: LocalizedStringKey = "infoTitle"
    let supportMe: LocalizedStringKey = "supportMe"
    let btnDeleteMyData: LocalizedStringKey = "btnDeleteMyData"
    let alertDeleteQuestion: LocalizedStringKey = "alertDeleteQuestion"
    let btnDelete: LocalizedStringKey = "btnDelete"
    let btnCancel: LocalizedStringKey = "btnCancel"
    let alertRestartQuestion: LocalizedStringKey = "alertRestartQuestion"
    let btnRebase: LocalizedStringKey = "btnRebase"
    let rebaseTitleSuccess: LocalizedStringKey = "rebaseTitleSuccess"
    let rebaseTitleFail: LocalizedStringKey = "rebaseTitleFail"
    // MARK: - Version
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "(no version info)"
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "(no build info)"
    // MARK: - View
    var body: some View {
        VStack {
            HStack {
                //change to image
                Image(systemName: "chevron.backward")
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
            HStack {
                Button(btnDeleteMyData) {
                    deleteAlertFlag.toggle()
                    }
                .tint(.red)
                .alert(alertDeleteQuestion, isPresented: $deleteAlertFlag) {
                    Button(btnDelete, role: .destructive) {
                        vm.cleanUserData()
                        vm.saveLastSort(how: .showDefault)
                        restartAlertFlag.toggle()
                    }
                    Button(btnCancel, role: .cancel) {}
                }
                .alert(alertRestartQuestion, isPresented: $restartAlertFlag) {
                    Button("Ok") {
                        mainSheetFlag.toggle()
                    }
                }
                Button(btnRebase) {
                    rebaseFlag = vm.rebase()
                    rebaseAlertFlag.toggle()
                }
                .alert(rebaseFlag ? rebaseTitleSuccess : rebaseTitleFail, isPresented: $rebaseAlertFlag) {
                    Button("Ok") {
                        mainSheetFlag.toggle()
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
                
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
