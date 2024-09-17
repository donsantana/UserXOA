//
//  File.swift
//  
//
//  Created by Done Santana on 8/8/24.
//

import Foundation
import SwiftUI

public struct Configuration {

    public struct Colors {
        static var primary = Color(.systemGray)
        static var buttonBackground = Color(.systemBlue)
        static var buttonForeground = Color(.white)
        
        init(primary: Color, buttonBackground: Color,buttonForeground: Color) {
            Configuration.Colors.primary = primary
            Configuration.Colors.buttonForeground = buttonForeground
            Configuration.Colors.buttonBackground = buttonBackground
        }
    }
    
    public struct APIUrls {
        static var serverUrl: String = ""
        static var loginUrl: String = ""
        static var passRecoverUrl: String = ""
        static var createPassUrl: String = ""
        static var passChangeUrl: String = ""
        static var updateProfileUrl: String = ""
        static var registerUrl: String = ""
        static var newRegisterUrl: String = ""
        static var removeClient: String = ""
        
        public init(serverUrl: String, loginUrl: String,
             passRecoverUrl: String,
             createPassUrl: String,
             passChangeUrl: String,
             updateProfileUrl: String,
             registerUrl: String,
             newRegisterUrl: String,
             removeClient: String) {
            Configuration.APIUrls.serverUrl = serverUrl
            Configuration.APIUrls.loginUrl = serverUrl+loginUrl
            Configuration.APIUrls.passRecoverUrl = serverUrl+passRecoverUrl
            Configuration.APIUrls.createPassUrl = serverUrl+createPassUrl
            Configuration.APIUrls.passChangeUrl = serverUrl+passChangeUrl
            Configuration.APIUrls.updateProfileUrl = serverUrl+updateProfileUrl
            Configuration.APIUrls.registerUrl = serverUrl+registerUrl
            Configuration.APIUrls.newRegisterUrl = serverUrl+newRegisterUrl
            Configuration.APIUrls.removeClient = serverUrl+removeClient
        }
    }
}

//public struct APIUrls {
//    var loginUrl: String
//    var passRecoverUrl: String
//    var createPassUrl: String
//    var passChangeUrl: String
//    var updateProfileUrl: String
//    var registerUrl: String
//    var newRegisterUrl: String
//    var removeClient: String
//    
//    init(loginUrl: String,
//         passRecoverUrl: String,
//         createPassUrl: String,
//         passChangeUrl: String,
//         updateProfileUrl: String,
//         registerUrl: String,
//         newRegisterUrl: String,
//         removeClient: String) {
//        self.loginUrl = loginUrl
//        self.passRecoverUrl = passRecoverUrl
//        self.createPassUrl = createPassUrl
//        self.passChangeUrl = passChangeUrl
//        self.updateProfileUrl = updateProfileUrl
//        self.registerUrl = registerUrl
//        self.newRegisterUrl = newRegisterUrl
//        self.removeClient = removeClient
//    }
//}
//
//public struct Colors {
//    var primary = Color(.systemGray)
//    var buttonBackground = Color(.systemBlue)
//    var buttonForeground = Color(.white)
//    
//    init(primary: Color, buttonBackground: Color,buttonForeground: Color) {
//        self.primary = primary
//        self.buttonForeground = buttonForeground
//        self.buttonBackground = buttonBackground
//    }
//}
