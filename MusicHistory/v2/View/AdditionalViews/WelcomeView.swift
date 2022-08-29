//
//  WelcomeView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/28/22.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("show_welcome") var showWelcome = true
    // image property
    @State private var angle = 10.0
    @State private var rotateX = 100.0
    @State private var rotateY = -100.0
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView {
                        ZStack {
                            previewImage2
                                .offset(x: 70, y: 0)
                            previewImage3
                                .offset(x: 0, y: 10)
                            previewImage
                                .offset(x: -70, y: 20)
                    }
                        .padding(.vertical, 30)
                    previewText
                    Group {
                        historicalSequence
                        saveProgress
                        exploreDifferent
                    }
                    .padding()
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
                    Image("bs")
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
                    Image("beatles")
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
                    Image("frank")
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
        Text("Welcome to\nMusic History")
            .font(.system(size: 40))
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
    }
    private var historicalSequence: some View {
        HStack {
            Image(systemName: "person.2")
                .foregroundColor(.accentColor)
                .font(.system(size: 30))
                .frame(width: 60, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text("Historical Sequence")
                    .font(.headline)
                Text("Some text some text some text some text some text some text some text")
                    .foregroundColor(.gray)
            }
        }
    }
    private var saveProgress: some View {
        HStack {
            Image(systemName: "list.bullet.rectangle.portrait")
                .foregroundColor(.accentColor)
                .font(.system(size: 30))
                .frame(width: 60, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text("Save Progress")
                    .font(.headline)
                Text("Some text some text some text some text some text some text some text")
                    .foregroundColor(.gray)
            }
        }
    }
    private var exploreDifferent: some View {
        HStack {
            Image(systemName: "aqi.medium")
                .foregroundColor(.accentColor)
                .font(.system(size: 30))
                .frame(width: 60, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text("Explore Different")
                    .font(.headline)
                Text("Some text some text some text some text some text some text some text")
                    .foregroundColor(.gray)
            }
        }
    }
    private var closeButton: some View {
        ZStack {
            Rectangle()
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .blur(radius: 20, opaque: true)
            Text("Continue")
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
                }
        }
    }
}
