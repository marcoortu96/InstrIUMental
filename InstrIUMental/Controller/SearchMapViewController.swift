//
//  SearchMapViewController.swift
//  InstrIUMental
//
//  Created by Emanuele Spano on 11/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SearchMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let ads : [Ad] = AdFactory.getInstance().getAds()
    var annotations = [MKAnnotation]()
    
    
    @IBAction func userPosition(_ sender: UIBarButtonItem) {
        locationManager.startUpdatingLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() == true {
            if  CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
            
        }else{
            print("Impostare su ON i servizi di localizzazione GPS")
        }
        
        addAdsToMap()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Impossibile accedere alla posizione corrente")
    }
    
    
    func addAdsToMap() {
        
        for l in ads  {
            let ad = l
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude : ad.getLatitude(), longitude : ad.getLongitude())
            annotation.coordinate = centerCoordinate
            annotation.title = ad.getTitle()
            annotation.subtitle = ad.getCategory()
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }

    
}

