//
//  SwiftUIView.swift
//  
//
//  Created by Done Santana on 9/11/24.
//

import SwiftUI

struct PasswordField: View {
    @Binding var text: String
    @Binding var hidePassword: Bool
    var inputType: InputType = .password
    var body: some View {
        
        Group {
            ZStack(alignment: .trailing) {
                if hidePassword {
                    SecureField(inputType.placeholder, text: $text)
                } else {
                    TextField(inputType.placeholder ?? inputType.placeholder,
                              text: $text)
                }
                Button {
                    hidePassword.toggle()
                } label: {
                    Text(Image(systemName: $hidePassword.wrappedValue ? "eye" : "eye.slash"))
                }
            }
        }
    }
}

//#Preview {
//    //PasswordField(showPassword:,inputType: .password,text: "")
//}
