//
//  SearchMapViewController.swift
//  InstrIUMental
//
//  Created by Emanuele Spano on 11/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit
import GoogleMaps

class SearchMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GMSServices.provideAPIKey("AIzaSyDlpx0HWAPyEzY03osumMUVZOGKm5Cc3GM")
        // Create a GMSCameraPosition that tells the map to display the
        // coordinates of the Palace of Sciences in Cagliari
        let camera = GMSCameraPosition.camera(withLatitude: 39.222508, longitude: 9.114050, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 39.245296, longitude: 9.164942)
        marker.title = "Le Vele Quartucciu"
        marker.snippet = "Cagliari-Italia"
        marker.map = mapView
    }
    


}
