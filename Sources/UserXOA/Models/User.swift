//
//  File.swift
//
//
//  Created by Done Santana on 8/13/24.
//

import Foundation
import UIKit

struct User {
    var idUsuario: Int
    var id: Int
    var user: String
    var nombreApellidos: String
    var email: String
    var idEmpresa: Int
    var empresa: String
    var foto: String
    var yapa: Double
    //var fotoImage: UIImage
//    var latitud: Double
//    var longitud: Double
    
    init(idUsuario: Int, id: Int, user: String, nombreApellidos: String, email: String, idEmpresa: Int, empresa: String, foto: String, yapa: Double, fotoImage: UIImage) {
        self.idUsuario = idUsuario
        self.id = id
        self.user = user
        self.nombreApellidos = nombreApellidos
        self.email = email
        self.idEmpresa = idEmpresa
        self.empresa = empresa
        self.foto = foto
        self.yapa = yapa
        //self.fotoImage = fotoImage
//        self.latitud = latitud
//        self.longitud = longitud
    }
    
    init(jsonData: [String: Any]) {
        print(jsonData)
        self.idUsuario = jsonData["idusuario"] as? Int ?? 0
        self.id = jsonData["idcliente"] as? Int ?? 0
        self.user = !(jsonData["movil"] is NSNull) ? jsonData["movil"] as! String : ""
        self.nombreApellidos = jsonData["nombreapellidos"] as? String ?? ""
        self.email = !(jsonData["email"] is NSNull) ? jsonData["email"] as! String : ""
        self.idEmpresa = !(jsonData["idempresa"] is NSNull) ? jsonData["idempresa"] as! Int : 0
        self.empresa = !(jsonData["empresa"] is NSNull) ? jsonData["empresa"] as! String : ""
        self.foto = !(jsonData["foto"] is NSNull) ? jsonData["foto"] as! String : ""
        self.yapa = !(jsonData["yapa"] is NSNull) ? jsonData["yapa"] as! Double : 0.0
//        self.fotoImage = UIImage(named: "chofer") ?? UIImage()
//        
//        let url = URL(string:"\(Configuration.APIUrls.authenticationUrl)/\(self.foto)")
//        
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard let data = data, let image = UIImage(data: data), error == nil else { return }
//            fotoImage = image
//        }
//        task.resume()
    }
    
    static var mockUser = User(idUsuario: 1, id: 1, user: "7864476521", nombreApellidos: "Done Test", email: "test@test.com", idEmpresa: 1, empresa: "XOA", foto: "foto-68-1705682195784.png", yapa: 0.0, fotoImage: UIImage())
}


class ClientLogged: ObservableObject {
    @Published var client: UserViewmodel = UserViewmodel(model: User.mockUser)
}
