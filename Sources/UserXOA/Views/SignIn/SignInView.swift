//
//  SwiftUIView.swift
//  
//
//  Created by Done Santana on 8/7/24.
//

import SwiftUI
import UIKit

public struct SignInView: View {
    @State var alertData = AlertData()
    @State var viewmodel: UserViewmodel
    @State private var email = ""
    @State private var password = ""
    @State var showAlert = false
    
    public var body: some View {
        NavigationStack {
            Spacer()
            VStack(spacing: 20) {
                Image("loginImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                VStack(spacing: 20) {
                    InputView(inputType: .telefono, text: $email, isValid: .constant(true))
                    InputView(inputType: .password, isSecureField: true, text: $password, isValid: .constant(true))
                }
                .padding(.horizontal)
                .padding(.top,12)
                
                NavigationLink {
                    ClaveRecoverView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text(GlobalStrings.recoverPasswordButtonTitle)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.systemBlue))
                        .frame(width: UIScreen.main.bounds.width - 30,alignment: .trailing)
                }
                
                
                Button {
                   loginUser()
                } label: {
                    Text(GlobalStrings.loginButtonTitle)
                        .font(.system(size: 20))
                        .foregroundStyle(Configuration.Colors.buttonForeground)
                        .frame(width: UIScreen.main.bounds.width - 30,height: 48)
                }
                .background(Configuration.Colors.buttonBackground)
                .clipShape(.rect(cornerRadius: 10))
                .alert("Login",isPresented: $showAlert) {
                    Button {
                        
                    } label: {
                        Text(GlobalStrings.aceptarButtonTitle)
                    }
                } message: {
                    Text(alertData.message)
                }
                
                Spacer()
                
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("No has creado tu cuenta?")
                        Text("Crear un cuenta")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 16))
                }
                
                NavigationLink {
                    ProfileView(viewModel: UserViewmodel(model: User.mockUser))
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Profile Test")
                    }
                    .font(.system(size: 16))
                }
            }
            .padding(.top, 15)
        }
    }
    
    public init() {
        viewmodel = UserViewmodel(model: User.mockUser)
    }
    
    func loginUser() {
        UserAPI.shared.loginToAPIService(user: email, password: password, completion: { result in
            switch result {
            case .success(let data):
                print("Token \(data["token"] as? String)")
                UserDefaults.standard.set(data["token"] as! String, forKey: "accessToken")
            case .failure(let error):
                var errorMessage = ""
                switch error {
                case .invalidResponse(let message),.serverError(message: let message):
                    errorMessage = message
                default:
                    errorMessage = error.localizedDescription
                }
                alertData = AlertData(title: GlobalStrings.errorTitle,message: errorMessage)
                showAlert = true
                print("error")
            }
        })
    }
}

#Preview {
    //SignInView(authManager: AuthManager())
    SignInView()
}
