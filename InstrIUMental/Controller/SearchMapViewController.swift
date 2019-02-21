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

class SearchMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var adDetailView: UIView!
    
    @IBOutlet weak var mapBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var adTitle: UILabel!
    @IBOutlet weak var adPrice: UILabel!
    @IBOutlet weak var adAuthor: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let ads : [Ad] = AdFactory.getInstance().getAds()
    var annotations = [MKAnnotation]()
    var adToWatch : Ad? = nil
    
    @IBOutlet weak var myPositionButton: UIButton!
    @IBAction func positionMe(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPositionButton.layer.cornerRadius = 20
        
        adDetailView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        mapView.addGestureRecognizer(tap)
        
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        
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
    
    @objc func handleTap (sender: UITapGestureRecognizer) {
        mapView.reloadInputViews()
        adDetailView.isHidden = true
        mapBottomConstraint.constant = 0
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() //keyboard disappear
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Impossibile accedere alla posizione corrente")
    }
    
    
    func addAdsToMap() {
        
        for ad in ads  {
            if ad.getAuthor() != UserFactory.getLoggedUser(usrs: UserFactory.getInstance().getUsers())?.getUsername() {
                
                let annotation = MKPointAnnotation()
                let centerCoordinate = CLLocationCoordinate2D(latitude : ad.getLatitude(), longitude : ad.getLongitude())
                annotation.coordinate = centerCoordinate
                annotation.title = ad.getTitle()
                annotation.subtitle = ad.getCategory()
                annotations.append(annotation)
            }
        }
        mapView.addAnnotations(annotations)
    }
    
    @IBAction func showAdDetail(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AdDetailViewController") as? AdDetailViewController
        vc?.adTitle = adToWatch!.getTitle()
        vc?.adText = adToWatch!.getText()
        vc?.category = adToWatch!.getCategory()
        vc?.price = String(adToWatch!.getPrice())
        vc?.author = adToWatch!.getAuthor()
        vc?.date = adToWatch!.getDate()
        vc?.adId = adToWatch!.getId()
        vc?.region = adToWatch!.getRegion()
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if ((view.annotation?.coordinate.latitude != locationManager.location?.coordinate.latitude) && (view.annotation?.coordinate.longitude != locationManager.location?.coordinate.longitude)) {
            adDetailView.isHidden = false
            mapBottomConstraint.constant = 93
            
            
            for ad in ads {
                
                if ad.getTitle() == view.annotation?.title {
                    
                    var currentPrice = String(Float(round(ad.getPrice() * 100) / 100))
                    if (currentPrice.components(separatedBy: ".")[1]).count == 1 {
                        currentPrice = currentPrice + "0"
                    }
                    adImageView.image = ad.getImage()[0]
                    adImageView.contentMode = .scaleAspectFill
                    adImageView.clipsToBounds = true
                    adTitle.text = ad.getTitle()
                    adPrice.text = currentPrice + " €"
                    
                    adAuthor.text = "di " +  ad.getAuthor()
                    adToWatch = ad
                }
                
            }
            
            
        }
    }
    
    
}

