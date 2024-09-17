//
//  SwiftUIView.swift
//  
//
//  Created by Done Santana on 8/19/24.
//

import SwiftUI

//struct ProfileUpdateAlert {
//    var title: String
//    var message: String
//}

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel: UserViewmodel
    @State var alertData: AlertData = AlertData(title: "", message: "")
    
    @State var userName: String = ""
    @State var phoneNumber: String = ""
    @State var email: String = ""
    @State var showCamera = false
    @State var isPhotoUpdated = false
    @State var selectedImage: UIImage? {
        didSet {
            isPhotoUpdated = true
        }
    }
    @State private var showingRemoveAlert = false
    @State private var showingProfileAlert = false
    @State private var showingRemoveResultAlert = false
  
    var body: some View {
        NavigationStack {
            HStack {
                Text(GlobalStrings.profileViewTitle)
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
            List {
                Section() {
                    HStack {
                        VStack(spacing: -10)  {
                            if let image = selectedImage {
                                Image(uiImage: selectedImage!)
                                    .resizable()
                                    .frame(width: 72,height: 72)
                                    .scaledToFit()
                                    .clipShape(Circle())
                            } else {
                                AsyncImage(url: URL(string:"\(Configuration.APIUrls.serverUrl)/\(viewModel.photo)")) { image in
                                    image.resizable()
                                        .frame(width: 72,height: 72)
                                        .scaledToFit()
                                        .clipShape(Circle())
                                } placeholder: {
                                    Text(viewModel.initials)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(width: 72, height: 72)
                                        .background(Color(.lightGray))
                                        .clipShape(Circle())
                                }
                            }
                            Button {
                               //openCamera()
                            } label: {
                                Image(systemName: "camera")
                                    .fullScreenCover(isPresented: $showCamera) {
                                        accessCameraView(selectedImage: $selectedImage)
                                            .edgesIgnoringSafeArea(.all)
                                    }
                                    .onTapGesture {
                                        showCamera = true
                                    }
                            }
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.fullname)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(viewModel.email)
                                .font(.subheadline)
                                .foregroundStyle(Color(.lightGray))
                        }
                    }
                }
                
                Section(GlobalStrings.personalInformationTitle) {
                    InputView(inputType: .telefono, showUnderLine: false, text: $phoneNumber, isValid: .constant(true),isDisable: true, placeholder: viewModel.telefono).foregroundStyle(.gray)
                    InputView(inputType: .fullname, showUnderLine: false, text: $userName, isValid: .constant(true), placeholder: viewModel.fullname).foregroundStyle(.gray)
                    InputView(inputType: .email, showUnderLine: false, text: $email, isValid: .constant(true), placeholder: viewModel.email).foregroundStyle(.gray)
                    //Update
                    Button {
                        updateProfile()
                    } label: {
                        Text(GlobalStrings.updateClientButtonTitle)
                            .foregroundStyle(Configuration.Colors.buttonForeground)
                            .frame(width: UIScreen.main.bounds.width - 60, height: 35)
                    }
                    .background(Configuration.Colors.buttonBackground)
                    .clipShape(.rect(cornerRadius: 10))
                    .alert(alertData.title, isPresented: $showingProfileAlert) {
                        Button {
            //                if success {
            //                    self.goToInicioView()
            //                }
                        } label: {
                            Text(GlobalStrings.aceptarButtonTitle)
                        }
                    } message: {
                        Text(alertData.message)
                    }
                }
                
                Section(GlobalStrings.passwordTitle) {
                    NavigationLink {
                        PasswordResetView(viewmodel: UserViewmodel(model: User.mockUser))
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text(GlobalStrings.updatePasswordButtonTitle)
                            .foregroundStyle(Color(.darkGray))
                            .frame(width: UIScreen.main.bounds.width - 60, height: 35)
                    }
                }
                
                Section(GlobalStrings.sessionTitle) {
                    //Log out
                    Button {
                        exit(0)
                    } label: {
                        Text(GlobalStrings.logoutButtonTitle)
                            .foregroundStyle(.gray)
                    }
                    //Remove client
                    Button {
                        showingRemoveAlert = true
                    } label: {
                        Text(GlobalStrings.removeClientButtonTitle)
                            .foregroundStyle(.red)
                    }
                    .alert(GlobalStrings.removeClientTitle, isPresented: $showingRemoveAlert) {
                        Button {
                           removeClient()
                        } label: {
                            Text(GlobalStrings.removeButtonTitle)
                        }
                        Button {
                            
                        } label: {
                            Text(GlobalStrings.cancelarButtonTitle)
                        }
                    } message: {
                        Text(GlobalStrings.removeClientMessage)
                    }
                    .alert(alertData.title, isPresented: $showingRemoveResultAlert) {
                        Button {
                            if alertData.title == "Usuario Eliminado" {
                                exit(0)
                            }
                        } label: {
                            Text(GlobalStrings.aceptarButtonTitle)
                        }
                    } message: {
                        Text(alertData.message)
                    }

                }
            }
            
        }
    }
    
    internal func removeClient() {
        UserAPI.shared.removeClientAPI(user: viewModel.telefono) { result in
            var title = ""
            var errorMessage = ""
            switch result {
            case .success(let message):
                title = "Usuario Eliminado"
                errorMessage = message
            case .failure(let error):
                switch error {
                case .invalidResponse(message: let message):
                    title = "Error"
                    errorMessage = message
                case .serverError(message: let message):
                    title = "Error"
                    errorMessage = message
                default:
                    title = "Error"
                    errorMessage = error.localizedDescription
                }
            }
            alertData = AlertData(title: "",message: errorMessage)
            showingRemoveResultAlert = true
        }
    }
    
    internal func profileIsUpdated() -> Bool {
        return viewModel.fullname != userName
    }
    
    internal func updateProfile() {
        if userName.isEmpty && email.isEmpty && selectedImage == nil {
            alertData = AlertData(title: "Perfil", message: "Los datos del perfil no han sido modificados")
            showingProfileAlert = true
        } else {
            let params = [
                "idUsuario": viewModel.idUsuario as Any,
                "nombreapellidos": userName.isEmpty ? viewModel.fullname : userName as Any,
                "movil": viewModel.telefono as Any,
                "email": email.isEmpty ? viewModel.email : email as Any,
            ] as [String : Any]
            
            UserAPI.shared.updateProfileAPI(parameters: params as [String: AnyObject], newPhoto: selectedImage) { result in
                switch result {
                case .success(let jsonResult):
                    print(jsonResult)
                    viewModel.updateProfile(jsonData: jsonResult["datos"] as! [String: Any])
                    //                let modelUpdated = User(jsonData: jsonResult["datos"] as! [String: Any])
                    //                self.model = modelUpdated
                    //globalVariables.cliente.updateProfile(jsonData: jsonResult["datos"] as! [String: Any])
                    self.showProfileUpdated(success: true, message: jsonResult["msg"] as? String ?? "")
                case .failure(let error):
                    var errorMessage = ""
                    switch error {
                    case .invalidResponse(message: let message):
                        errorMessage = message
                    case .serverError(message: let message):
                        errorMessage = message
                    default:
                        errorMessage = error.localizedDescription
                    }
                    self.showProfileUpdated(success: false,message: errorMessage)
                }
            }
        }
    }
    
    internal func showProfileUpdated(success: Bool, message: String) {
        alertData = AlertData(title: success ? GlobalStrings.profileUpdatedTitle :  GlobalStrings.errorTitle, message: message)
        showingProfileAlert = true
    }
    
//    func removeClient() {
//        let okAction = UIAlertAction(title: GlobalStrings.eliminarButtonTitle, style: .destructive, handler: {_ in
//            ApiService.shared.removeClientAPI() { result in
//                switch result {
//                case .success(let message):
//                    self.showRemoveUser(message: message, success: true)
//                case .failure(let error):
//                    var errorMessage = ""
//                    switch error {
//                    case .invalidResponse(message: let message):
//                        errorMessage = message
//                    case .serverError(message: let message):
//                        errorMessage = message
//                    default:
//                        errorMessage = error.localizedDescription
//                    }
//                    self.showRemoveUser(message: errorMessage, success: false)
//                }
//            }
//        })
//        let cancelAction = UIAlertAction(title: GlobalStrings.noButtonTitle, style: .default, handler: {_ in
//            
//        })
//        Alert.showBasic(title: GlobalStrings.removeClientTitle, message: GlobalStrings.removeClientMessage, vc: self, withActions: [okAction, cancelAction])
//    }
}

#Preview {
    //ProfileView()
    ProfileView(viewModel: UserViewmodel(model: User.mockUser))
}

