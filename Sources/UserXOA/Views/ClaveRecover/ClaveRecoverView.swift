//
//  SwiftUIView.swift
//  
//
//  Created by Done Santana on 8/19/24.
//

import SwiftUI

struct ClaveRecoverView: View {
    @State var numeroTelefono: String = ""
    @State var isValidated: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(GlobalStrings.passwordRecoverTitle)
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
            
            Text(GlobalStrings.passwordRecoverSubtitle)
                .font(.system(size:14))
            InputView(inputType: .telefono, text: $numeroTelefono, isValid: .constant(true))
            Button {
                
            } label: {
                Text("Enviar")
                    .font(.system(size: 20))
                    .foregroundStyle(Configuration.Colors.buttonForeground)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 48)
            }
            .background(Configuration.Colors.buttonBackground)
            .clipShape(.rect(cornerRadius: 10))
            
        }
        .padding(.all, 20)

    }
}

#Preview {
    ClaveRecoverView(numeroTelefono: "7864476528")
}
