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
    var location: AnyObject?
    
    let settingBarView = SettingBarView()
    let locationView = LocationView()
    let mapView = MapView()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        navigationController?.navigationBar.barTintColor = .systemPurple
        navigationController?.navigationBar.isTranslucent = false // default 반투명 제거.
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        title = "Korean Air"
        
        view.backgroundColor = .yellow
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
//        locationManager.requestWhenInUseAuthorization() // 위치 정보 사용 여부 물어보기.
        locationManager.distanceFilter = 2000.0
        
        view.addSubview(settingBarView)
        view.addSubview(locationView)
        view.addSubview(mapView)
        
        settingBarView.delegate = self
        
        settingBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        locationView.anchor(top: settingBarView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        mapView.anchor(top: locationView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }


}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.location = locations.last
        
        guard let location = location else { return }
        mapView.configureMap(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG: error = \(error.localizedDescription)")
    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .notDetermined:
//            self.locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            <#code#>
//        case .denied:
//            <#code#>
//        case .authorizedAlways:
//            <#code#>
//        case .authorizedWhenInUse:
//            <#code#>
//        @unknown default:
//            <#code#>
//        }
//    }
}

// MARK: - SettingBarViewDelegate

extension ViewController: SettingBarViewDelegate {
    
    func listButtonDidTap() {
        print("DEBUG: push vc")
    }
    
    
}
