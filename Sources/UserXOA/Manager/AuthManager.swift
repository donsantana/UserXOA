//
//  File.swift
//  
//
//  Created by Done Santana on 8/16/24.
//

import Foundation
import SwiftUI

public final class AuthManager {
    //static var share = AuthManager(primary: .white, buttonBackground: .blue, buttonForeground: .white)

    public init() {}
    
    public init(primary: Color, buttonBackground: Color, buttonForeground: Color,
                serverUrl: String,
                loginUrl: String,
                passRecoverUrl: String,
                createPassUrl: String,
                passChangeUrl: String,
                updateProfileUrl: String,
                registerUrl: String,
                newRegisterUrl: String,
                removeClient: String) {
        Configuration.Colors(primary: primary, buttonBackground: buttonBackground, buttonForeground: buttonForeground)
        Configuration.APIUrls(
            serverUrl: serverUrl,
            loginUrl: loginUrl,
            passRecoverUrl: passRecoverUrl,
            createPassUrl: createPassUrl,
            passChangeUrl: passChangeUrl,
            updateProfileUrl: updateProfileUrl,
            registerUrl: registerUrl,
            newRegisterUrl: newRegisterUrl,
            removeClient: removeClient
        )
    }
    
    public func signInView() -> any View {
        //return SignInView(authManager: self)
        return SignInView()
    }
}
