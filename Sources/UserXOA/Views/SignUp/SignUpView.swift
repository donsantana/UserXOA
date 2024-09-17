//
//  SwiftUIView.swift
//  
//
//  Created by Done Santana on 8/7/24.
//

import SwiftUI


struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    //@ObservedObject var viewModel: UserViewmodel
    @State var alertData = AlertData()
    
    @State private var numeroTelefono = ""
    @State private var nombreApellidos = ""
    @State private var password = ""
    @State private var confirmaPassword = ""
    @State private var email = ""
    
    @State private var isValidPhone = true
    @State private var isValidFullname = true
    @State private var isValidPassword = true
    @State private var isValidConfirmaPassword = true
    @State private var isValidEmail = true
    @State private var showErrorAlert = false
    
    @State private var registerInputTypes: [InputType] = [.telefono, .fullname, .password, .confirmPassword, .email]
    
    var body: some View {
        HStack {
            Text("Ingrese sus datos")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, 20)
        
        List{
            Section {
                VStack(alignment: .leading) {
                    Text("Sus datos personales estarán protegidos.\nSomos expertos en seguridad informática.")
                        .font(.system(size: 12))
                        .fontWeight(.light)
                        .foregroundStyle(.gray)
                }
                .listRowSeparator(.hidden)
                VStack(spacing: 20) {
                    InputView(inputType: .telefono, text: $numeroTelefono, isValid: $isValidPhone)
                    InputView(inputType: .fullname, text: $nombreApellidos, isValid: $isValidFullname, messageText: "El conductor confirmará que ha recogido a la persona adecuada por su nombre.")
                    InputView(inputType: .password, text: $password, isValid: $isValidPassword)
                    InputView(inputType: .confirmPassword, text: $confirmaPassword, isValid: $isValidConfirmaPassword)
                    InputView(inputType: .email, text: $email, isValid: $isValidEmail, messageText: "Tanqui, no enviamos SPAM.")
                }
                
                Button {
                    registerUser()
                } label: {
                    Text("Crear la cuenta")
                        .font(.system(size: 20))
                        .foregroundColor(Configuration.Colors.buttonForeground)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 45)
                }
                .background(Configuration.Colors.buttonBackground)
                .clipShape(.rect(cornerRadius: 10))
                .listRowSeparator(.hidden)
                .alert("", isPresented: $showErrorAlert) {
                    
                } message: {
                    Text(alertData.message)
                }
            }
        }
    
//        .padding(.horizontal)
        //.padding(.top, 25)
    }
    
    internal func validadateFields() {

        if numeroTelefono.isEmpty || nombreApellidos.isEmpty || password.isEmpty || confirmaPassword.isEmpty || email.isEmpty {
            alertData = AlertData(title: "", message: "Debe llenar todos los campos de formulario.")
        }
        showErrorAlert = true
    }
    
    internal func registerUser() {
        validadateFields()
//        let params = [
//            "password": password,
//            "movil": numeroTelefono,
//            "nombreapellidos": nombreApellidos,
//            "email": email,
//            "so": "IOS",
//            "version": "3.6.0",
//            "recomendado": ""]
//        //["email": "test@test.com", "movil": "7864476520", "so": "IOS", "nombreapellidos": "Done Test", "recomendado": "", "password": "ok", "version": "3.6.0"]
//        UserAPI.shared.registerUserAPI(url: Configuration.APIUrls.registerUrl, params: params, completion: { result in
//            print(result)
////            switch result {
////            case .success(let result):
////                switch result["statusCode"] as! Int {
////                case 201:
////                    //registration success
////                    let okAction = UIAlertAction(title: GlobalStrings.aceptarButtonTitle, style: .default, handler: {alertAction in
////                        self.goToLoginView()
////                    })
////                    Alert.showBasic(title: "Éxito", message: msg, vc: self, withActions: [okAction])
////                case 404:
////                    //Codigo de activacion invalido o caducado
////                    let okAction = UIAlertAction(title: GlobalStrings.aceptarButtonTitle, style: .default, handler: {alertAction in
////                        self.showCodeVerificationView()
////                    })
////                    Alert.showBasic(title: "", message: msg, vc: self, withActions: [okAction])
////                case 400:
////                    //Codigo generenado, revise Whatsapp
////                    showCodeVerificationView()
////                case 409:
////                    //Usuarion Existente
////                    let okAction = UIAlertAction(title: GlobalStrings.aceptarButtonTitle, style: .default, handler: {alertAction in
////                        self.goToLoginView()
////                    })
////                    Alert.showBasic(title: "", message: msg, vc: self, withActions: [okAction])
////                case 410:
////                    //Usuarion Existente
////                    let okAction = UIAlertAction(title: GlobalStrings.aceptarButtonTitle, style: .default, handler: {alertAction in
////                        self.waitingView.isHidden = true
////                    })
////                    Alert.showBasic(title: "", message: msg, vc: self, withActions: [okAction])
////                default:
////                    //General Error
////                    let okAction = UIAlertAction(title: GlobalStrings.aceptarButtonTitle, style: .default, handler: {alertAction in
////                        self.waitingView.isHidden = true
////                    })
////                    Alert.showBasic(title: "", message: GlobalStrings.errorGenericoMessage, vc: self, withActions: [okAction])
////                }
////            case .failure(let error):
////                print(error.localizedDescription)
////            }
//        })
    }
}

#Preview {
    //SignUpView(viewModel: UserViewmodel(model: User.mockUser))
    SignUpView()
}
