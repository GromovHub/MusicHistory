//
//  SignUpView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/31/22.
//

import SwiftUI
import Combine
// Models
enum PasswordStatus {
    case empty
    case notStrong
    case repeatedWrong
    case valid
}
// ViewModels
class SignUpViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    
    @Published var isValid = false
    
    @Published var inlinePasswordError = ""
    @Published var inlineUsernameError = ""
    
    private var cancelleables = Set<AnyCancellable>()
    
    private var isValidUsernamePublisher: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{ $0.count >= 3 }
            .eraseToAnyPublisher()
    }
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{ $0.isEmpty }
            .eraseToAnyPublisher()
    }
    private var arePasswordEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordAgain)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{$0 == $1}
            .eraseToAnyPublisher()
    }
    private var isPasswordStrongPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{ $0.count > 6 }
            .eraseToAnyPublisher()
    }
    private var PasswordStatusPublisher: AnyPublisher<PasswordStatus, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, arePasswordEqualPublisher, isPasswordStrongPublisher)
            .map {
                if $0 { return PasswordStatus.empty }
                if !$1 { return PasswordStatus.repeatedWrong }
                if !$2 { return PasswordStatus.notStrong }
                return PasswordStatus.valid
            }
            .eraseToAnyPublisher()
    }
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(PasswordStatusPublisher, isValidUsernamePublisher)
            .map {
                $0 == PasswordStatus.valid && $1 == true
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancelleables )
        PasswordStatusPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { passwordStatus in
                switch passwordStatus {
                case .empty:
                    return "Empty Password"
                case .notStrong:
                    return "Weak Password"
                case .repeatedWrong:
                    return "Wrong Repeated Password"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlinePasswordError, on: self)
            .store(in: &cancelleables )
        isValidUsernamePublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0 ? "" : "Short Username"}
            .assign(to: \.inlineUsernameError, on: self)
            .store(in: &cancelleables)
            
    }
    
}
// Views
struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Username", text: $vm.username)
                            .textInputAutocapitalization(TextInputAutocapitalization.never)
                    } header: {
                        Text("Username")
                    } footer: {
                        Text("\(vm.inlineUsernameError)")
                            .foregroundColor(.red)
                    }
                    Section {
                        SecureField("Password", text: $vm.password)
                        SecureField("Password again", text: $vm.passwordAgain)
                    } header: {
                        Text("Password")
                    } footer: {
                        Text("\(vm.inlinePasswordError)")
                            .foregroundColor(.red)
                    }
                }
                Button {
                    //action
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 60)
                        .overlay {
                            Text("Continue")
                                .foregroundColor(.white)
                        }
                }
                .padding()
                .disabled(!vm.isValid)
            }
            .navigationTitle("Sign Up")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
