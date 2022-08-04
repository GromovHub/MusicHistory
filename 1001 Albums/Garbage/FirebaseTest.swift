//
//  FirebaseTest.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/3/22.
//

import SwiftUI
import Firebase

struct FirebaseTest: View {
    var body: some View {
        FSignUpView()
    }
}

struct FHomeView: View {
    var body: some View {
        Text("home")
    }
}
struct FSignInView: View {
    var body: some View {
        Text("signin")
    }
}
struct FSignUpView: View {
    @State var userEmail = ""
    @State var userPassword = ""
    @State var signUpProcessing = false
    @State var navigationFlag = false
    func signUpUser(userEmail: String, userPassword: String) {
        signUpProcessing = true
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            print("hello")
            print(authResult,error)
            guard error == nil else {
                signUpProcessing = false
                return
            }
            switch authResult {
            case .none:
                print("Could not create account.")
                            signUpProcessing = false
            case .some(_):
                print("User created")
                            signUpProcessing = false
                navigationFlag = true
                
                           
            }
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                TextField("email", text: $userEmail)
                TextField("password", text: $userPassword)
                Button("signup") {
                    signUpUser(userEmail: userEmail, userPassword: userPassword)
                }
            }.navigationTitle("SignUp")
        }
        
    }
}




struct FirebaseTest_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseTest()
    }
}
