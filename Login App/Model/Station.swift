import Foundation
import SwiftUI

struct Station: Identifiable, Codable, Hashable {
    
    var id : String
    var NomStation : String
    var category : String
  //  var image : String
    var Région : String
    var latitude : String
   var longtitude : String
    
    init(NomStation: String, Région: String , id : String ,category : String , latitude : String , longtitude : String ) {
        self.id = id
        self.NomStation = NomStation
        self.Région = Région
        self.category = category
        self.latitude = latitude
        self.longtitude = longtitude
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case NomStation
        case category
       // case image
        case Région
        case latitude
        case longtitude
    }
}

struct  StationsDataModel:Codable{
    let Station:[Station]
}
