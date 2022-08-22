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
    @State var onboardingState = 3
    @State var name = ""
    @State var age: Double = 50
    @State var gender = ""
    var body: some View {
        ZStack {
            // content
            ZStack {
                switch onboardingState {
                case 0:
                    ScrollView {
                        welcomeSection
                    }
                case 1:
                    addNameSection
                case 2:
                    addAgeSection
                case 3:
                    addGenderSection
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
    
      private var bottomButton: some View {
            Text("Sign in")
                .font(.headline)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.white)
                .cornerRadius(10)
                .onTapGesture {
                    // action
                    self.onboardingState = 1
                }
    }
    
       private var welcomeSection: some View {
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
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(30)
    }
    
    private var addNameSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            TextField("Enter your name", text: $name)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(10)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addAgeSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text(String(format: "%.0f", age))
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Slider(value: $age, in: 18...100, step: 1)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addGenderSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Picker(selection: $gender) {
                Text("Male")
                    .tag("Male")
                Text("Female")
                    .tag("Female")
                Text("Non-Binary")
                    .tag("Non-Binary")
            } label: {
                Text("Select a gender")
                .font(.headline)
                .foregroundColor(.blue)
                .frame(width: 55)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(10)
            }
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}



