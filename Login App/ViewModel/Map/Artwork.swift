/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D
  
  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    
    super.init()
  }
  
  init?(feature: MKGeoJSONFeature) {
    // 1
    guard
      let point = feature.geometry.first as? MKPointAnnotation,
      // 2
      let propertiesData = feature.properties,
      let json = try? JSONSerialization.jsonObject(with: propertiesData),
      let properties = json as? [String: Any]
      else {
        return nil
    }
    
    // 3
    title = properties["title"] as? String
    locationName = properties["location"] as? String
    discipline = properties["discipline"] as? String
    coordinate = point.coordinate
    super.init()
  }
  
  var subtitle: String? {
    return locationName
  }
  
  var mapItem: MKMapItem? {
    guard let location = locationName else {
      return nil
    }
    
    let addressDict = [CNPostalAddressStreetKey: location]
    let placemark = MKPlacemark(
      coordinate: coordinate,
      addressDictionary: addressDict)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    return mapItem
  }
  
  var markerTintColor: UIColor  {
    switch discipline {
    case "Monument":
      return .red
    case "Train":
      return .cyan
    case "Bus":
      return .blue
    case "Sculpture":
      return .purple
    default:
      return .green
    }
  }
  
  var image: UIImage {
    guard let name = discipline else { return #imageLiteral(resourceName: "Flag") }
    
    switch name {
    case "Monument":
      return #imageLiteral(resourceName: "Monument")
    case "Metro":
      return #imageLiteral(resourceName: "Metro")
    case "Train":
      return #imageLiteral(resourceName: "Train")
    case "Bus":
      return #imageLiteral(resourceName: "Bus")
    case "Sculpture":
      return #imageLiteral(resourceName: "Sculpture")
    case "Plaque":
      return #imageLiteral(resourceName: "Plaque")
    case "Mural":
      return #imageLiteral(resourceName: "Mural")
    default:
      return #imageLiteral(resourceName: "Flag")
    }
  }
}
