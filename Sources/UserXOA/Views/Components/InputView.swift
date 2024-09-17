//
//  SwiftUIView.swift
//  
//
//  Created by Done Santana on 8/7/24.
//

import SwiftUI

enum InputType {
    case telefono
    case email
    case currentPassword
    case password
    case confirmPassword
    case fullname
    
    var title: String {
        switch self {
        case .telefono:
            return "Usuario"
        case .email:
            return "Email address"
        case .password:
            return "Clave"
        case .currentPassword:
            return "Clave actual"
        case .confirmPassword:
            return "Confirmar la clave"
        case .fullname:
            return "Nombre y apellidos"
        }
    }

    var placeholder: String {
        switch self {
        case .telefono:
            return "Número de teléfono"
        case .email:
            return "Correo electrónico si posee"
        case .password:
            return "Teclee su clave"
        case .currentPassword:
            return "Teclee su clave actual"
        case .confirmPassword:
            return "Confirme su clave"
        case .fullname:
            return "Nombre y Apellidos"
        }
    }
    
    var errorMessage: String {
        switch self {
        case .telefono:
            return "Número de teléfono incorrecto"
        case .email:
            return "Correo electrónico incorrecto"
        case .password:
            return "Clave incorrecta"
        case .currentPassword:
            return "Clave actual incorrecta"
        case .confirmPassword:
            return "Las claves no coinciden"
        case .fullname:
            return "Nombre y apellidos incorrecto"
        }
    }
}

struct InputView: View {
    let inputType: InputType
    var isSecureField = false
    var showUnderLine = true
    
    @Binding var text: String
    @Binding var isValid: Bool
   
    @State var hidePassword = true
    @State var isDisable = false
    @State var messageText: String = ""
    @State var errorAlertText: String = ""
    @State var placeholder: String?

    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(inputType.title)
                .foregroundColor(Color(.gray))
                .fontWeight(.semibold)
                .font(.subheadline)

            if isSecureField {
                PasswordField(text: $text, hidePassword: $hidePassword, inputType: inputType)
            } else {
                TextField(placeholder ?? inputType.placeholder,
                          text: $text,
                          onEditingChanged: { isEditing in
                    if !isEditing {
                        validateText()
                    }
                })
                .textInputAutocapitalization(.never)
                .disabled(isDisable)
            }
            
            if showUnderLine {
                Divider()
            }
            
            if !errorAlertText.isEmpty || !messageText.isEmpty {
                ZStack {
                    Text(!isValid ? errorAlertText : messageText)
                        .font(.system(size: 12))
                        .foregroundColor(Color(!isValid ? .systemRed : .lightGray))
                }
            }
        }
    }
    
    internal func validateText() {
        switch inputType {
        case .email:
           isValid = validateEmail()
        case .telefono:
           isValid = validateTelefono()
        default:
           isValid = validateTextEmpty()
        }
        
        //showErrorText = !isValid ? true : false
        errorAlertText = !isValid ? inputType.errorMessage : ""
    }
    
    internal func validateTextEmpty() -> Bool {
        return !text.isEmpty
    }
    
    internal func validateEmail() -> Bool {
        if text.isEmpty {
            messageText = "Email incorrecto."
            return false
        } else {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
               let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
               return emailPredicate.evaluate(with: text)
        }
    }
    
    internal func validateTelefono() -> Bool {
        return text.count == 10 && text.isNumeric
    }
}

#Preview {
    InputView(inputType: .email, text: .constant(""), isValid: .constant(true))
}
