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
    lazy var sideMenuView: SideMenuView = {
        let view = SideMenuView()
        view.setDimensions(width: self.view.frame.width - 100, height: self.view.frame.height)
        return view
    }()
    
    let mapView = MapView()
    
    lazy var sideMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_action_updown"), for: .normal)
        button.tintColor = .white
//        button.setImage(UIImage(named: "ic_action_updown_pressed"), for: .highlighted) // 안해도 딱히 문제는 없는듯,,, ( type: .system) 이기 때문
        button.addTarget(self, action: #selector(sideMenuButtonDidTap), for: .touchUpInside)
        button.setDimensions(width: 40, height: 40)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_action_search"), for: .normal)
        button.tintColor = .white
//        button.setImage(UIImage(named: "ic_action_search_pressed"), for: .highlighted) //
        button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        button.setDimensions(width: 40, height: 40)
        return button
    }()
    
    
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
    
    @objc func sideMenuButtonDidTap() {
        var x: CGFloat = 0
        var alpha: CGFloat = 0.0
        
        if sideMenuButton.tag == -1 {
            sideMenuButton.tag = 0
            alpha = 0.7
            x = sideMenuView.frame.width
        } else {
            sideMenuButton.tag = -1
            alpha = 0.0
            x = sideMenuView.frame.width * -1
        }
        
        UIView.animate(withDuration: 0.3) {
            self.sideMenuView.frame.origin.x = x
            self.view.backgroundColor = UIColor.black.withAlphaComponent(alpha)
        }
        
    }
    
    @objc func searchButtonDidTap() {
        let searchViewController = SearchViewController()
        title = ""
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        navigationController?.navigationBar.barTintColor = .systemPurple
        navigationController?.navigationBar.isTranslucent = false // default 반투명 제거.
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: sideMenuButton), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(customView: searchButton), animated: true)
        
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
            y = locationView.frame.origin.y // 로케이션뷰를 덮으면서 펼쳐짐
        } else {
            y = locationView.frame.origin.y - 260 // 로케이션뷰 위쪽, 세팅바 뒤로 감춰짐
        }
        
        UIView.animate(withDuration: 0.3) {
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
    
    func didScroll(view: UIView, recognizer: UIPanGestureRecognizer) {
        let delta = recognizer.translation(in: self.view)

        if recognizer.state == .changed {
            if delta.y <= 0 {
                self.settingBarView.tag = -1
                view.frame.origin.y = settingBarView.frame.origin.y + settingBarView.frame.height + delta.y
            }
        } else if recognizer.state == .ended {
            if delta.y > -view.frame.height / 2 { // FilterView 높이의 절반 이하 만큼 드래그함 강제 drag down. (다시 열림)
                settingBarView.tag = -1
                animateSettingView(tag: settingBarView.tag)
            } else { // FilterView 높이의 절반 이하보다 많이 드래그함. 강제 drag up. (닫힘)
                settingBarView.tag = 0
                animateSettingView(tag: settingBarView.tag)
            }
        }
    }
    
}
