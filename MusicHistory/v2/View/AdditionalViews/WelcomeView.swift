//
//  WelcomeView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/28/22.
//

import SwiftUI

struct WelcomeView: View {
    // MARK: - State
    @AppStorage("show_welcome") var showWelcome = true
    @AppStorage("main_sheet_flag") var mainSheetFlag = true
    var locate = Locale.current.languageCode
    // MARK: - Animation Property
    @State private var angle = 10.0
    @State private var rotateX = 100.0
    @State private var rotateY = -100.0
    // MARK: - Localizable
    let welcomeTitle: LocalizedStringKey = "welcomeTitle"
    let historicalTitle: LocalizedStringKey = "historicalTitle"
    let historicalDespription: LocalizedStringKey = "historicalDespription"
    let saveTitle: LocalizedStringKey = "saveTitle"
    let saveDescription: LocalizedStringKey = "saveDescription"
    let exploreTitle: LocalizedStringKey = "exploreTitle"
    let exploreDescription: LocalizedStringKey = "exploreDescription"
    let btnClose: LocalizedStringKey = "btnClose"
    // MARK: - View
    var body: some View {
        VStack {
            ZStack {
                ScrollView(.vertical) {
                        ZStack {
                            previewImage2
                                .offset(x: 70, y: 0)
                            previewImage3
                                .offset(x: 0, y: 10)
                            previewImage
                                .offset(x: -70, y: 20)
                    }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 30)
                    previewText
                    // Features
                    Group {
                        historicalSequence
                        saveProgress
                        exploreDifferent
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                VStack {
                    Spacer()
                    closeButton
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

// MARK: - Components

extension WelcomeView {
    private var previewImage: some View {
        ZStack {
            LinearGradient(colors: [Color.purple, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 150, height: 150)
                .cornerRadius(20)
                    Image("bs200")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .cornerRadius(20)
                        .shadow(radius: 10)
        }
        .rotation3DEffect(.degrees(angle), axis: (x: CGFloat(rotateX), y: CGFloat(rotateY), z: 0.0))
        .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: angle)
        .onAppear {
            angle = -10.0
            rotateX = -100.0
            rotateX = -100.0
        }
    }
    private var previewImage2: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 150, height: 150)
                .cornerRadius(20)
                    Image("beatles200")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .cornerRadius(20)
                        .shadow(radius: 10)
        }
        .rotation3DEffect(.degrees(angle), axis: (x: CGFloat(rotateX), y: CGFloat(rotateY), z: 0.0))
        .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: angle)
        .onAppear {
            angle = -10.0
            rotateX = -100.0
            rotateX = -100.0
        }
    }
    private var previewImage3: some View {
        ZStack {
            LinearGradient(colors: [Color.red, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 150, height: 150)
                .cornerRadius(20)
                    Image("frank200")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .cornerRadius(20)
                        .shadow(radius: 10)
        }
        .rotation3DEffect(.degrees(angle), axis: (x: CGFloat(rotateX), y: CGFloat(rotateY), z: 0.0))
        .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: angle)
        .onAppear {
            angle = -10.0
            rotateX = -100.0
            rotateX = -100.0
        }
    }
    private var previewText: some View {
        Text(welcomeTitle)
            .font(.system(size: locate == "en" ? 40 : 30))
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
    }
    private var historicalSequence: some View {
        HStack {
            Image(systemName: "person.2")
                .foregroundColor(.accentColor)
                .font(.system(size: 30))
                .frame(width: 80, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text(historicalTitle)
                    .font(.headline)
                Text(historicalDespription)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    private var saveProgress: some View {
        HStack {
            Image(systemName: "list.bullet.rectangle.portrait")
                .foregroundColor(.accentColor)
                .font(.system(size: 30))
                .frame(width: 80, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text(saveTitle)
                    .font(.headline)
                Text(saveDescription)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    private var exploreDifferent: some View {
        HStack {
            Image(systemName: "aqi.medium")
                .foregroundColor(.accentColor)
                .font(.system(size: 30))
                .frame(width: 80, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text(exploreTitle)
                    .font(.headline)
                Text(exploreDescription)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    private var closeButton: some View {
        ZStack {
            Rectangle()
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .blur(radius: 20, opaque: true)
            Text(btnClose)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(15)
                .padding(.horizontal)
                .offset(y: -30)
                .onTapGesture {
                    showWelcome.toggle()
                    mainSheetFlag.toggle()
                }
        }
    }
}
