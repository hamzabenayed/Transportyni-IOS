//
//  APIHandler.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 5/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//
/*
import Foundation
import Alamofire
class APIHandler {
    static let sharedInstance = APIHandler()
    func fetchinAPIData(handler : @escaping(_ apiData:[Station])->(Void)){
        let url = "http://172.17.8.43:9090/user/getStation"
        AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default,headers: nil,interceptor: nil).response{
            responce in
            switch responce.result{
            case .success(let data):
                do  {
                    let jsondata = try JSONDecoder().decode([Station].self,from: data!)
                    handler(jsondata)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure (let error):
            print(error.localizedDescription)
            }
        }
    }
}

struct Station:Codable{
    let _id:String
    let Région:String
    let NomStation:String

}
*/
