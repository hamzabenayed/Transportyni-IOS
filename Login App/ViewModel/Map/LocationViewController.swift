//
//  LocationViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 2/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var MyLocationVC: MKMapView!
    
    
    var locationManager = CLLocationManager()
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        
        if isLocationServiceEnabled() {
            
        checkAuthorization()
            
            
        }else {
            ShowAlert(msg: "Please enable location Service" )
        }
        
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
            MyLocationVC.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            MyLocationVC.showsUserLocation = true
            break
        case .denied:
            ShowAlert(msg: "Please authorize access to location")
            break
        case .restricted:
            ShowAlert(msg: "Authorization restricted")
            break
        default:
            print("default")
            break
        }
        
    }
    
    func ShowAlert(msg: String) {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .default))
        present(alert,animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if let location = locations.last{
            print("location: \(location.coordinate)")
            ZoomToUserLocation(location: location)
     }
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        
        switch status{
       
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            MyLocationVC.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            MyLocationVC.showsUserLocation = true
            break
        case .denied:
            ShowAlert(msg: "Please authorize access to location")
            break
     
        default:
            print("default")
            break
        }
    
    }
    
    
    func ZoomToUserLocation(location : CLLocation){
        let region = MKCoordinateRegion(center : location.coordinate , latitudinalMeters: 500,longitudinalMeters: 500)
        
        MyLocationVC.setRegion(region, animated: true)
    }
    

}
