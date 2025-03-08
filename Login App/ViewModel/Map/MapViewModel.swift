//
//  MapViewModel.swift
//  Transportyni App
//
//  Created by HAMZA & MONDHER 4SIM5 on 14/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import Foundation

import SwiftUI
import MapKit

// All Map data Goes here

class MapViewModel: ObservableObject{
    @Published var mapView = MKMapView()
    // Region
    @Published var region : MKCoordinateRegion!
    // based on location it will set
}
