//
//  MapViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 19/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate,UISearchBarDelegate {
    
    
    @IBOutlet weak var textdestination: UITextField!
    
    @IBOutlet weak var textsearch: UITextField!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    @IBOutlet weak var mapView: MKMapView!
    private var artworks: [Artwork] = []
    
    var locationManager = CLLocationManager()
    
    @IBAction func Searchbutton2(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
                searchController.searchBar.delegate = self
                present(searchController, animated: true, completion: nil)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //create two dummy locations
        let loc1 = CLLocationCoordinate2D.init(latitude: 36.834062, longitude: 10.103733)
        let loc2 = CLLocationCoordinate2D.init(latitude: 36.844062, longitude: 10.113733)

        //find route
        showRouteOnMap(pickupCoordinate: loc1, destinationCoordinate: loc2)
        mapView.addAnnotations(artworks)
        mapView.register(
            ArtworkView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
          
          loadInitialData()
          mapView.addAnnotations(artworks)
      
        
        
        let intialLoc = CLLocation(latitude: 36.856187 , longitude: 10.148163)
        
        setStartingLocation(location: intialLoc, distance: 20000)
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if isLocationServiceEnabled() {
            
            checkAuthorization()
            
            
        }else {
            ShowAlert(msg: "Please enable location Service",type: "locationsService" )
        }
        mapView.delegate = self


            
        }
    
    @IBAction func textFieldReturn(_ sender: UITextField) {
        _ = sender.resignFirstResponder()
           mapView.removeAnnotations(mapView.annotations)
           self.performSearch()
        
    }
    
   
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = textsearch.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if let results = response {
            
                if let err = error {
                    print("Error occurred in search: \(err.localizedDescription)")
                } else if results.mapItems.count == 0 {
                    print("No matches found")
                } else {
                    print("Matches found")
                    
                    for item in results.mapItems {
                        print("Name = \(item.name ?? "No match")")
                        print("Phone = \(item.phoneNumber ?? "No Match")")
                        
                        self.matchingItems.append(item as MKMapItem)
                        print("Matching items = \(self.matchingItems.count)")
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = item.placemark.coordinate
                        annotation.title = item.name
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }
        })
    }
    
    func mapView22(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.red
         renderer.lineWidth = 5.0
         return renderer
    }
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
            request.requestsAlternateRoutes = true
            request.transportType = .automobile

            let directions = MKDirections(request: request)

            directions.calculate { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }
                
                //for getting just one route
                if let route = unwrappedResponse.routes.first {
                    //show on map
                    self.mapView.addOverlay(route.polyline)
                    //set the map area to show the route
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
                }

                //if you want to show multiple routes then you can get all routes in a loop in the following statement
                for route in unwrappedResponse.routes {}
            }
        }
    private func loadInitialData() {
      // 1
      guard
    
        let fileName = Bundle.main.url(forResource: "PublicArt", withExtension: "geojson"),
        let artworkData = try? Data(contentsOf: fileName)
        else {
          return
      }
      
      do {
        // 2
        let features = try MKGeoJSONDecoder()
          .decode(artworkData)
          .compactMap { $0 as? MKGeoJSONFeature }
        let Qrcode = "Test"
        // 3
        let validWorks = features.compactMap(Artwork.init)
        // 4
        artworks.append(contentsOf: validWorks)
          
      } catch {
        // 5
        print("Unexpected error: \(error).")
      }
    }
    
    
    func setStartingLocation(location: CLLocation, distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000000000000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        
        
    }
    
    
    func isLocationServiceEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func checkAuthorization() {
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:
            ShowAlert(msg: "Please authorize access to location",type: "authSettings")
            break
        case .restricted:
            ShowAlert(msg: "Authorization restricted",type: "default")
            break
        default:
            print("default")
            break
        }
        
        
    }
    
    func ShowAlert(msg: String,type : String) {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .default))
        alert.addAction(UIAlertAction(title: "settings", style: .default, handler: { action in
            if type == "locationService" {
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }else if type == "authSettigns" {
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
            
        }))
        
        present(alert,animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        
        switch status{
            
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:
            ShowAlert(msg: "Please authorize access to location",type: "locationsServices")
            break
            
        default:
            print("default")
            break
        }
        
        
        
        
        func ZoomToUserLocation(location : CLLocation){
            let region = MKCoordinateRegion(center : location.coordinate , latitudinalMeters: 10000000,longitudinalMeters: 10000500)
            
            mapView.setRegion(region, animated: true)
        }
        
        
        //Searchbar
        
        
        
        
        
        
        // Annotaion View
        
        
        
        
        
        
    }
    
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000000000000000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: 36.856187,
      longitudinalMeters: 10.148163)
    setRegion(coordinateRegion, animated: true)
  }
}

extension MapViewController {
  func mapView(
    _ mapView: MKMapView,
    annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl
  ) {
    guard let artwork = view.annotation as? Artwork else {
      return
    }
    
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    artwork.mapItem?.openInMaps(launchOptions: launchOptions)
  }
}


