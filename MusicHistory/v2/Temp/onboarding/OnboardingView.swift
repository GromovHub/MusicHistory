//
//  OnboardingView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/22/22.
//

import SwiftUI

struct OnboardingView: View {
    /*
     0 - welcome
     1 - add name
     2 - add age
     3 - add gender
     */
    @State var onboardingState = 0
    var body: some View {
        ZStack {
            // content
            ZStack {
                switch onboardingState {
                case 0:
                    welcomeSection
//                case 1:
//                case 2:
//                case 3:
                default:
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.green)
                }
            }
            // buttons
            VStack {
                Spacer()
                bottomButton
            }
            .padding()
        }
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .background(.cyan)
    }
}

// MARK: - Components

extension OnboardingView {
    
        var bottomButton: some View {
            Text("Sign in")
                .font(.headline)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.white)
                .cornerRadius(10)
                .onTapGesture {
                    // action
                }
    }
    
        var welcomeSection: some View {
            VStack(spacing: 40) {
                Spacer()
                Image(systemName: "heart.text.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)
                Text("Find your match.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .overlay (
                        Capsule(style: .continuous)
                            .frame(height: 3)
                            .foregroundColor(.white)
                            .offset(y: 5),
                        alignment: .bottom
                    )
                Text("In this example we will focus on persisting the data with @AppStorage and making beautiful animations with the .transition modifier.")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                Spacer()
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(30)
    }
}



