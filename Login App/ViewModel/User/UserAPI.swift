//
//  UserAPI.swift
//  Eltorno
//
//  Created by Mac-Mini-2021 on 08/12/2021.
//

import Foundation
import UIKit
import SendbirdUIKit


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}
func generateBoundary() -> String {
      return "Boundary-\(NSUUID().uuidString)"
  }
func DataBody(user:User, media: [Media]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
    
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"firstname\"\(lineBreak + lineBreak)")
        body.append("\(user.firstName! + lineBreak)")
    
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"lastname\"\(lineBreak + lineBreak)")
        body.append("\(user.lastName! + lineBreak)")
    
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"mobile\"\(lineBreak + lineBreak)")
        body.append("\(user.mobile! + lineBreak)")
        
        
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"email\"\(lineBreak + lineBreak)")
        body.append("\(user.email! + lineBreak)")
    
    
      /*  if !(user.password ?? "").isEmpty{
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"password\"\(lineBreak + lineBreak)")
            body.append("\(user.password! + lineBreak)")
        }*/
       
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }

class UserAPI{
   
    
    func login(email: String,mdp: String,callback: @escaping (Bool,Any?)->Void){
            
        let params = [
                "email": email,
                "password":mdp
            ]
            guard let url = URL(string: "http://172.17.0.214:9090/user/login") else{
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            
            let session = URLSession.shared.dataTask(with: request){
                data, response, error in
                DispatchQueue.main.async {
                    if error != nil{
                        print(error)
                    }else {
                        
                        if let jsonRes  = try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [String: Any]{
                            if !(jsonRes["accessToken"] == nil) {
                                //UserDefaults.standard.setValue(jsonRes["token"], forKey: "tokenConnexion")
                                UserDefaults.standard.setValue(jsonRes["accessToken"], forKey: "tokenConnexion")
                            }
                            if let reponse = jsonRes["user"] as? [String: Any]{
                                
                                for (key,value) in reponse{
                                    
                                    UserDefaults.standard.setValue(value, forKey: key)
                                    
                                }
                                SBUGlobals.CurrentUser = SBUUser(userId: UserDefaults.standard.string(forKey: "_id")!)
                                 callback(true,"good")
                                
                            }else{
                                callback(false,jsonRes)
                            }
                        }else{
                            callback(false,"erreur ici")
                        }
                    }
                }
                
            }.resume()
            
        }
    
    
    func UpdateProfil(user:User,  callback: @escaping (Bool,String?)->Void){
            
        guard let url = URL(string: "http://172.17.0.214:9090/user/"+UserDefaults.standard.string(forKey: "_id")!) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            //create boundary
            
            let boundary = generateBoundary()
            //set content type
      //      let token = UserDefaults.standard.string(forKey: "tokenConnexion")!
       //     request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        //    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            //print("token est la : ",UserDefaults.standard.string(forKey: "tokenConnexion")!)
            //call createDataBody method
            
        //   let dataBody = DataBody(user:user, media: [mediaImage], boundary: boundary)
       //     request.httpBody = dataBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let response = response {
                    }
                    if let data = data {
                        do {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print("houni",json)
                                        if let validUser = json["user"] as? [String:Any]{
                                            for (key,value) in validUser{
                                                UserDefaults.standard.setValue(value, forKey: key)
                                            }
                                        }
                                        callback(true,"updated")

                            }
                        } catch {
                            callback(false,nil)
                        }
                    }else{
                        callback(false,nil)}}
            }.resume()
        }

    
    
    
    
    func deleteProfil ( callback: @escaping (Bool,String?)->Void){
            guard let url = URL(string: "http://localhost:3000/user/"+UserDefaults.standard.string(forKey: "_id")!) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "Bearer \(UserDefaults.standard.string(forKey: "tokenConnexion")!)", forHTTPHeaderField: "Authorization")
            let session = URLSession.shared.dataTask(with: request){
                data, response, error in
                DispatchQueue.main.async {
                    if error != nil{
                        print("there is error")
                    }else {
                        if let jsonRes  = try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [String: Any]{
                            if var reponse = jsonRes["reponse"] as? String{
                                if reponse.contains("succes") {
                                    callback(true,reponse)

                                }else{
                                    callback(false,reponse)
                                }
                                //print(reponse)
                            }
                            else{
                                callback(false,nil)
                            }
                        }else{
                            callback(false,nil)
                        }
                    }
                }
                
            }.resume()
        }
    
    
    
    func forgotPassword (email:String, callback: @escaping (Bool,Any?)->Void){
            
            guard let url = URL(string: "http://localhost:3000/forgotPassword") else {return}
            var request = URLRequest(url: url)
            let params = [
                "email": email
            ]
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            let session = URLSession.shared.dataTask(with: request){
                data, response, error in
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                    if (json["succes"] as! Int == 1){
                        callback(true,json["token"] as! String)

                    }else{
                        callback(false,"error")
                    }
                }else{
                    callback(false,"erreur")
                }
            }.resume()
        }
    
    func resetPass(password : String, email:String, code:String , callback: @escaping (Bool,Any?)->Void){
           
           guard let url = URL(string: "http://localhost:3000/resetPassword/"+email+"/"+code) else {return}
           var request = URLRequest(url: url)
           let params = [
               "password": password
           ]
           
           request.httpMethod = "POST"
           request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
           request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
           let session = URLSession.shared.dataTask(with: request){
               data, response, error in
               if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                   if json["reponse"] as! String == "Your password has been successfully reset"{
                       callback(true,"reset done")
                   }
                   else{
                       callback(false,json)
                   }
               }
           }.resume()
   }

}


extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
    
  
}


  



