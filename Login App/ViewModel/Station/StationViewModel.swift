//
//  StationViewModel.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 8/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import Foundation

var Static = Staticcs()


class StationViewModel: ObservableObject{
    
    
    @Published var stations = [Station] ()
    
    func getAllStation(){
        
        guard let url = URL(string: Static.URL+"/user/getStation") else {
            print("not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data , res , error) in
            if error != nil
            {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([Station].self, from: data)
                    DispatchQueue.main.async {
                        self.stations = result
                        
                    }
                }
                else {
                    print ("no data")
                }
            } catch let JsonError {
                
                print("fetch json error :", JsonError.localizedDescription)
                print(String(describing: JsonError))
            }
        }.resume()
    }
}
