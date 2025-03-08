//
//  MapView.swift
//  Transportyni App
//
//  Created by HAMZA & MONDHER 4SIM5 on 14/11/2022.

//


import SwiftUI
// 1.
import MapKit

struct MapView: View {
    // 2.
    @State private var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 40.83834587046632,
                    longitude: 14.254053016537693),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.03,
                    longitudeDelta: 0.03)
                )

    var body: some View {
        // 3.
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
    struct MapView_Previews: PreviewProvider{
        static var previews: some View{
            MapView ()
        }
    }
}
