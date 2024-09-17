//
//  File.swift
//  
//
//  Created by Done Santana on 8/9/24.
//

import Foundation
import UIKit


enum APIError: Error {
    case invalidURL
    case invalidResponse(message: String)
    case invalidData
    case serverError(message: String)
}

struct UserAPI {
    
    static var shared = UserAPI()
    
    private func apiPOSTRequest(url: String, params: Dictionary<String, String>) -> URLRequest{
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer token", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func registerUserAPI(url: String, params: Dictionary<String, String>, completion: @escaping (Result<Dictionary<String, AnyObject>, APIError>) -> Void) {
        print("register URL: \(url)")
        print(params)
        let request = self.apiPOSTRequest(url: url, params: params)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let error = error {
                completion(.failure(.serverError(message: error.localizedDescription)))
                return
            }
            
            do {
                var json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
              
                print("json \(json["msg"] as! String)")
                
                guard let response = response as? HTTPURLResponse, (200...410).contains(response.statusCode) else {
                    completion(.failure(.invalidResponse(message: json["msg"] as? String ?? "")))
                    return
                }
                json["statusCode"] = response.statusCode as AnyObject
                completion(.success(json))
            } catch {
                completion(.failure(.invalidData))
            }
        })
        task.resume()
    }
    
    func loginToAPIService(user: String, password: String, completion: @escaping (Result<[String: Any], APIError>) -> Void) {
        let params = ["user": user, "password": password, "version": "3.6.0"] as Dictionary<String, String>
        print("URL: \(Configuration.APIUrls.loginUrl)")
        guard let url = URL(string: Configuration.APIUrls.loginUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                completion(.failure(.serverError(message: error.localizedDescription)))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print("json \(json)")
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(.invalidResponse(message: json["msg"] as? String ?? "")))
                    return
                }
                completion(.success(json as [String: Any]))
            } catch {
                completion(.failure(.invalidData))
            }
        })
        task.resume()
    }
    
    func updateProfileAPI(parameters: [String: AnyObject],newPhoto: UIImage?, completion: @escaping (Result<[String: Any], APIError>) -> Void) {
        //let recordedFilePath = NSHomeDirectory() + "/Library/Caches/Image"
        let mimetype = "image/jpeg"
        guard let url = URL(string: Configuration.APIUrls.updateProfileUrl) else { return }
        var request : NSMutableURLRequest = NSMutableURLRequest()
        let body = NSMutableData()
        let boundary = "--------14737809831466499882746641449----"
        //Add extra parameters
       
        request = URLRequest(url: url) as! NSMutableURLRequest
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserDefaults.standard.value(forKey: "accessToken") as! String)", forHTTPHeaderField: "Authorization")
        
        for (key, value) in parameters {
            body.append(("--\(boundary)\r\n").data(using: .utf8)!)
            body.append(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n").data(using: .utf8)!)
            body.append(("\(value)\r\n").data(using: .utf8)!)
        }
        
        var fileData: Data = UIImage(named: "chofer")!.jpegData(compressionQuality: 1.0)!
        if let newImage = newPhoto {
            fileData = newImage.jpegData(compressionQuality: 1.0)!
        }
        
        //Add File to body
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"\r\n\r\n".data(using: .utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(parameters["idUsuario"] as? String).png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body as Data
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.serverError(message: error.localizedDescription ?? "")))
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(.invalidResponse(message: json["msg"] as? String ?? "")))
                    return
                }
                completion(.success(json))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func uploadFile(serverUrl: String, parameters: [String: AnyObject]?,localFilePath: String, fileName: String, mimetype: String, completion: @escaping (Result<[String: Any], APIError>) -> Void) {
        
        guard let url = URL(string: serverUrl) else {return}
        var request : NSMutableURLRequest = NSMutableURLRequest()
        let body = NSMutableData()
        let boundary = "--------14737809831466499882746641449----"
        //Add extra parameters
        if parameters != nil {
            for (key, value) in parameters! {
                body.append(("--\(boundary)\r\n").data(using: .utf8)!)
                body.append(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n").data(using: .utf8)!)
                body.append(("\(value)\r\n").data(using: .utf8)!)
            }
        }
        
        request = URLRequest(url: url) as! NSMutableURLRequest
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserDefaults.standard.value(forKey: "accessToken") as! String)", forHTTPHeaderField: "Authorization")
        
        let recordedFilePath = localFilePath + fileName
        print(recordedFilePath)
        let recordedFileURL = URL(fileURLWithPath: recordedFilePath)
        let fileData: Data? = try? Data(contentsOf: recordedFileURL)
        
        //Add File to body
        if fileData != nil{
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"file\"\r\n\r\n".data(using: .utf8)!)
            body.append("hi\r\n".data(using: String.Encoding.utf8)!)
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            body.append(fileData!)
            body.append("\r\n".data(using: String.Encoding.utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        } else {
            print("Errrorrrrr")
        }
        request.httpBody = body as Data
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if error == nil && statusCode == 200 {
                if mimetype == "image/jpeg" {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        completion(.success(json))
                        
                    } catch {
                        completion(.failure(.invalidData))
                    }
                } else {
                    completion(.failure(.invalidResponse(message: GlobalStrings.errorGenericoMessage)))
                }
                print("file uploaded")
            } else {
                if mimetype == "image/jpeg" {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        completion(.failure(.invalidResponse(message: json["msg"] as! String)))
                    } catch {
                        completion(.failure(.serverError(message: GlobalStrings.errorGenericoMessage)))
                    }
                } else {
                    completion(.failure(.serverError(message: GlobalStrings.errorGenericoMessage)))
                }
                print("error uploading file")
            }
        }
        task.resume()
    }
    
    func changeClaveAPI(params: Dictionary<String, String>, completion: @escaping (Result<String, APIError>) -> Void) {
        guard let url = URL(string: Configuration.APIUrls.passChangeUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserDefaults.standard.value(forKey: "accessToken") as! String)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                completion(.failure(.serverError(message: error.localizedDescription)))
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print("json \(json["msg"] as! String)")
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(.invalidResponse(message: json["msg"] as? String ?? GlobalStrings.errorGenericoMessage)))
                    return
                }
                completion(.success(json["msg"] as! String))
            } catch {
                completion(.failure(.invalidData))
            }
        })
        
        task.resume()
    }
    
    func removeClientAPI(user: String, completion: @escaping (Result<String, APIError>) -> Void) {
        print("USER \(user) - \(Configuration.APIUrls.removeClient)")
        guard let url = URL(string: Configuration.APIUrls.removeClient) else {return}
        
        let params: Dictionary<String, String> = ["movil": user]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(UserDefaults.standard.value(forKey: "accessToken") as! String)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(.serverError(message: error.localizedDescription)))
            }
            
            do {
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(.failure(.invalidResponse(message: GlobalStrings.usuarioEliminadoError)))
                    return
                }
                
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                completion(.success(json["msg"] as? String ?? GlobalStrings.usuarioEliminadoExito))
            } catch {
                completion(.failure(.invalidData))
            }
        })
        
        task.resume()
    }
    
    func fetchImage(url: String, completion: @escaping (Result<UIImage,APIError>) -> Void) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(message: error.localizedDescription)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse(message: "Bad response")))
                return
            }
            
            if let data = data {
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(.invalidData))
                }
            }
        }.resume()
    }
}
