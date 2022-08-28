//
//  WelcomeView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/28/22.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("show_welcome") var showWelcome = true
    
    @State private var angle = 12.0
    @State private var rotateX = 90.0
    @State private var rotateY = -45.0
    
    let btGradient = LinearGradient(colors: [Color.blue, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
    let snGradient = LinearGradient(colors: [Color.red, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
    let bsGradient = LinearGradient(colors: [Color.purple, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
    let gridItem = GridItem(.adaptive(minimum: 30, maximum: 180), spacing: 100, alignment: .top)
    
    let flexItem = GridItem(.flexible(minimum: 10, maximum: 100), spacing: 10, alignment: .center)
    let adaptItem = GridItem(.adaptive(minimum: 10, maximum: 200), spacing: 10, alignment: .center)
    var body: some View {
        VStack {
            HStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                Spacer()
            }.padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    //bt
                    ZStack {
                        btGradient
                            .frame(width: 100, height: 100)
                            .cornerRadius(25)
                        Image("beatles")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .rotation3DEffect(.degrees(angle), axis: (x: CGFloat(rotateX), y: CGFloat(rotateY), z: 0.0))

                    .animation(Animation.timingCurve(0.12, 0, 0.39, 0).repeatForever(autoreverses: true).speed(0.2), value: angle)
                    //sinatra
                    ZStack {
                        snGradient
                            .frame(width: 100, height: 100)
                            .cornerRadius(25)
                        Image("frank")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .rotation3DEffect(.degrees(angle), axis: (x: CGFloat(rotateX), y: CGFloat(rotateY), z: 0.0))
                    .animation(Animation.timingCurve(0.12, 0, 0.39, 0).repeatForever(autoreverses: true).speed(0.2), value: angle)
                    //bs (200:160)
                    scrElement
                    ZStack {
                        bsGradient
                            .frame(width: 100, height: 100)
                            .cornerRadius(25)
                        Image("bs")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .rotation3DEffect(.degrees(angle), axis: (x: CGFloat(rotateX), y: CGFloat(rotateY), z: 0.0))
                    .animation(Animation.timingCurve(0.12, 0, 0.39, 0).repeatForever(autoreverses: true).speed(0.2), value: angle)
//            .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true))
            .onAppear {
                angle = -12.0
                rotateX = -45.0
                rotateX = -90.0
                }
            }
            }
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
            Button {
                showWelcome = false
            } label: {
                Text("Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

extension WelcomeView {
    var scrElement: some View {
        //bt
        ZStack {
            btGradient
                .frame(width: 100, height: 100)
                .cornerRadius(25)
            Image("beatles")
                .resizable()
                .frame(width: 80, height: 80, alignment: .center)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .rotation3DEffect(.degrees(angle), axis: (x: CGFloat(rotateX), y: CGFloat(rotateY), z: 0.0))

        .animation(Animation.timingCurve(0.12, 0, 0.39, 0).repeatForever(autoreverses: true).speed(0.2), value: angle)
        .padding()
    }
}
