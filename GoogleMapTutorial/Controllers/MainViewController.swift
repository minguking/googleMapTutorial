//
//  ViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/03.
//

import UIKit
import CoreLocation

import GoogleMaps

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    var location: AnyObject?
    
    let settingBarView = SettingBarView()
    let filterView = FilterView()
    let locationView = LocationView()
    
    let mapView = MapView()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = "Korean Air"
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        navigationController?.navigationBar.barTintColor = .systemPurple
        navigationController?.navigationBar.isTranslucent = false // default 반투명 제거.
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        view.backgroundColor = .yellow
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization() // 위치 정보 사용 여부 물어보기.
        locationManager.distanceFilter = 2000.0
        
        view.addSubview(locationView)
        view.addSubview(mapView)
        view.addSubview(filterView)
        view.addSubview(settingBarView)
        
        filterView.delegate = self
        settingBarView.delegate = self
        
        locationView.anchor(top: settingBarView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        mapView.anchor(top: locationView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        filterView.anchor(top: settingBarView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -260, height: 260)
        settingBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
    }
    
    func animateSettingView(tag: Int) {
        var y: CGFloat = 0
        
        /**
            tag = 0 : 필터 접힘
            tag = -1 : 필터 펼쳐짐
         */
        
        if tag == -1 {
            y = locationView.frame.origin.y
        } else {
            y = locationView.frame.origin.y - 260
        }
        
        UIView.animate(withDuration: 0.2) {
            self.filterView.frame.origin.y = y
        }
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.location = locations.last
        
        guard let location = location else { return }
        mapView.configureMap(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG: error = \(error.localizedDescription)")
    }
    
//     사용자가 설정에서 위치 정보 사용 여부를 변경했을 시,,,
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else if status == .denied {
            print("DEBUG: location usage denied...")
//            locationManager.requestLocation()
        }
        print("DEBUG: status: \(status.rawValue)")
    }
}

// MARK: - SettingBarViewDelegate

extension MainViewController: SettingBarViewDelegate {
    
    func listButtonDidTap() {
        let parkingLotListVC = ParkingLotListViewController()
        title = ""
        navigationController?.pushViewController(parkingLotListVC, animated: true)
    }
    
    func filterDidTap(view: UIView) {
        animateSettingView(tag: view.tag)
    }
    
}

// MARK: - FilterViewDelegate

extension MainViewController: FilterViewDelegate {
    
    func dragButtonDidTap() {
        print("DEBUG: up")
        animateSettingView(tag: 0)
    }
    
}
