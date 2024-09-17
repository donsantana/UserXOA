//
//  File.swift
//  
//
//  Created by Done Santana on 8/13/24.
//

import Foundation
import UIKit

class UserViewmodel: ObservableObject {
    private var model: User
    
    init(model: User) {
        self.model = model
    }
    
    func updateProfile(jsonData: [String: Any]) {
        model.idUsuario = !(jsonData["idusuario"] is NSNull) ? jsonData["idusuario"] as! Int : 0
        model.id = !(jsonData["idcliente"] is NSNull) ? jsonData["idcliente"] as! Int : 0
        model.nombreApellidos = !(jsonData["nombreapellidos"] is NSNull) ? jsonData["nombreapellidos"] as! String : ""
        model.email = !(jsonData["email"] is NSNull) ? jsonData["email"] as! String : ""
        model.foto = !(jsonData["foto"] is NSNull) ? jsonData["foto"] as! String : ""
        //model.fotoImage = UIImage(named: "chofer") ?? UIImage()
//        let url = URL(string:"\(Configuration.APIUrls.authenticationUrl)/\(model.foto)")
//      
//      let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//          guard let data = data, let image = UIImage(data: data), error == nil else { return }
//          self.model.fotoImage = image
//      }
//      task.resume()
    }
    
    var initials: String {
        let firstname = model.nombreApellidos.components(separatedBy: " ").first!
        let lastname = model.nombreApellidos.components(separatedBy: " ").last!
        return "\(firstname.first ?? "U")\(lastname.first ?? "N")"
    }
    
    var idUsuario: Int {
      return model.idUsuario
    }
    
    var firstname: String {
      return model.nombreApellidos.components(separatedBy: " ").first!
    } 
    
    var fullname: String {
      return model.nombreApellidos
    }    
    
    var email: String {
      return model.email
    }    
    
    var telefono: String {
      return model.user
    }
    
    var photo: String {
        return model.foto
    }
    
    
    var photoImage:UIImage {
      return cargarPhoto()
    }
    
    func updateYapa(monto: Double) {
      model.yapa = monto.rounded()
    }
    
    func cargarPhoto() -> UIImage {
        var image = UIImage(named: "chofer")
      if model.foto != "" {
        let url = URL(string:"\(Configuration.APIUrls.loginUrl)/\(model.foto)")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
          guard let data = data, error == nil else { return }
          image = UIImage(data: data)
        }
        task.resume()
      } else {
        image = UIImage(named: "chofer")
      }
        
        return image!
    }
//    
//    func cargarPhoto(imageView: UIImageView) -> UIImage {
//      if model.foto != "" {
//        let url = URL(string:"\(Configuration.APIUrls.loginUrl)/\(model.foto)")
//        
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//          guard let data = data, error == nil else { return }
//          DispatchQueue.main.sync() {
//            imageView.contentMode = .scaleAspectFill
//            imageView.image = UIImage(data: data)
//          }
//        }
//        task.resume()
//      } else {
//        imageView.image = UIImage(named: "chofer")
//      }
//    }
    
    func closeSesion() {
        let fileAudio = FileManager()
        let AudioPath = NSHomeDirectory() + "/Library/Caches/Audio"
        do {
            try fileAudio.removeItem(atPath: AudioPath)
        } catch {
        }
        //self.socketService.socketEmit("SocketClose", datos: ["idcliente": globalVariables.cliente.id])
        exit(3)
    }
}
