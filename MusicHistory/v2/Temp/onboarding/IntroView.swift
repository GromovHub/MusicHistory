//
//  IntroView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/22/22.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("signed_in") var currentUserSignedIn = false
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]),
                           center: .topLeading,
                           startRadius: 5,
                           endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            if currentUserSignedIn {
                Text("Profile view")
            } else {
                Text("Onboarding view")
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
