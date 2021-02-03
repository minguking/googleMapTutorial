//
//  ViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/03.
//

import UIKit
import CoreLocation

import GoogleMaps

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    
    let camera = GMSCameraPosition(latitude: 37.52527719563531, longitude: 126.88309172816757, zoom: 16.0)
    
    lazy var mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .yellow
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = 2000.0
        locationManager.startUpdatingLocation()
        
        view.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.52527719563531, longitude: 126.88309172816757)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }


}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lat = locations.last?.coordinate.latitude
        let lon = locations.last?.coordinate.longitude
        
        print("DEBUG: lat = \(lat)")
        print("DEBUG: lon = \(lon)")
    }
}
