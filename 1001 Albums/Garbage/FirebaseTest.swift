//
//  FirebaseTest.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/3/22.
//

import SwiftUI
import Firebase

class FirebaseTestViewModel: ObservableObject {
    init() {
        
    }
    
    @Published var successFlag = true
    @Published var fullCoverActive = false
}

struct FirebaseTest: View {
    @StateObject var vm = FirebaseTestViewModel()
    var body: some View {
        if vm.successFlag {
            FHomeView(vm: vm)
        } else {
            FSignUpView(vm: vm)
        }
        
    }
}

struct FHomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: FirebaseTestViewModel
    var body: some View {
        VStack {
            Text("home")
            Button("go back") {
                presentationMode.wrappedValue.dismiss()
            }
            Button("open cover") {
                vm.fullCoverActive.toggle()
            }
            .fullScreenCover(isPresented: $vm.fullCoverActive) {
//                VStack {
//                    Text("You are in full screen cover")
//                    Button("close cover") {
//                        fullCoverActive.toggle()
//                    }
//                }
                FSignUpView(vm: vm)
            }
        }
    }
}
struct FSignInView: View {
    var body: some View {
        Text("signin")
    }
}
struct FSignUpView: View {
    @StateObject var vm: FirebaseTestViewModel
    @State var userEmail = ""
    @State var userPassword = ""
    @State var signUpProcessing = false
   
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
                vm.successFlag = true
                vm.fullCoverActive.toggle()
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
//                .fullScreenCover(isPresented: $successFlag) {
//                    FHomeView()
//                }
            }.navigationTitle("SignUp")
        }
        
    }
}




struct FirebaseTest_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseTest()
    }
}
