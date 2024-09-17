//
//  SwiftUIView.swift
//  
//
//  Created by Done Santana on 8/20/24.
//

import SwiftUI

struct AlertData {
    var title: String = ""
    var message: String = ""
}

struct PasswordResetView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewmodel: UserViewmodel
    @State var currentPassword = ""
    @State var newPassword = ""
    @State var confirmPassword = ""
    
    @State var isValidCurrentPassword = true
    @State var isValidNewPassword = true
    @State var isValidConfirmPassword = true
    
    @State var showAlert = false
    @State var alertData: AlertData = AlertData(title: "", message: "")
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(GlobalStrings.passwordTitle)
                    .font(.system(size:20))
                    .bold()
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal, 20)
            
            List {
                Section() {
                    InputView(inputType: .currentPassword, isSecureField: true, showUnderLine: false, text: $currentPassword, isValid: $isValidCurrentPassword).foregroundStyle(.gray)
                    InputView(inputType: .password, isSecureField: true, showUnderLine: false, text: $newPassword, isValid: $isValidNewPassword).foregroundStyle(.gray)
                    InputView(inputType: .confirmPassword, isSecureField: true, showUnderLine: false, text: $confirmPassword, isValid: $isValidConfirmPassword).foregroundStyle(.gray)
                }
                Button {
                   updatePassword()
                } label: {
                    Text(GlobalStrings.updatePasswordButtonTitle)
                        .foregroundStyle(Configuration.Colors.buttonForeground)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 35)
                }
                .background(Configuration.Colors.buttonBackground)
                .clipShape(.rect(cornerRadius: 10))
            }
        }
        .alert(alertData.title, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text(GlobalStrings.aceptarButtonTitle)
            }
        } message: {
            Text(alertData.message)
        }
    }
    
    func updatePassword() {
        if currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty {
            alertData = AlertData(title: GlobalStrings.missedDataTitle, message: GlobalStrings.missedDataMessage)
            showAlert = true
        } else {
            UserAPI.shared.changeClaveAPI(params: ["user": viewmodel.telefono, "password": currentPassword, "newpassword": newPassword]) { result in
                var title = ""
                var message = GlobalStrings.errorGenericoMessage
                showAlert = true
                switch result {
                case .success(let messge):
                    title = GlobalStrings.cambioClavesTitle
                    message = messge
                case .failure(let error):
                    title = GlobalStrings.errorTitle
                    message = error.localizedDescription
                }
                
                alertData = AlertData(title: title, message: message)
                //            DispatchQueue.main.async {
                //              let alertaDos = UIAlertController (title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                //              alertaDos.addAction(UIAlertAction(title: GlobalStrings.aceptarButtonTitle, style: .default, handler: {alerAction in
                //                self.dismiss()
                //              }))
                //              self.present(alertaDos, animated: true, completion: nil)
                //            }
            }
        }
    }
}

#Preview {
    PasswordResetView(viewmodel: UserViewmodel(model: User.mockUser))
}
