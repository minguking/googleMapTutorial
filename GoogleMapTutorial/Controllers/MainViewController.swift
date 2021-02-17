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
    
    private let locationManager = CLLocationManager()
    private var location: AnyObject?
    
    private let settingBarView = SettingBarView()
    private let filterView = FilterView()
    private let locationView = LocationView()
    
    lazy var sideMenuView: SideMenuView = {
        let view = SideMenuView()
//        view.setDimensions(width: self.view.frame.width - 100, height: self.view.frame.height)
        return view
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.isHidden = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(backViewDidTap))
        view.addGestureRecognizer(recognizer)
        return view
    }()
    
    private let mapView = MapView()
    
    lazy var sideMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_action_updown"), for: .normal)
        button.tintColor = .white
        button.tag = -1
        /*
         -1: 접혀진 상태
          0: 펼쳐진 상태.
        */
//        button.setImage(UIImage(named: "ic_action_updown_pressed"), for: .highlighted) // 안해도 딱히 문제는 없는듯,,, ( type: .system) 이기 때문
        button.addTarget(self, action: #selector(sideMenuButtonDidTap), for: .touchUpInside)
        button.setDimensions(width: 40, height: 40)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_action_search"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        button.setDimensions(width: 40, height: 40)
        return button
    }()
    
    lazy var edgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleLeftEdgeGesture(sender:)))
        recognizer.edges = .left
        view.gestureRecognizers = [recognizer]
        return view
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 사이드 메뉴 커스텀 보더라인,,,
        sideMenuView.mobileTicketView.layer.addBorder([.right], color: .lightGray, width: 0.5)
        sideMenuView.mobileTicketView.layer.addBorder([.bottom], color: .lightGray, width: 1)
        sideMenuView.parkingPassView.layer.addBorder([.left], color: .lightGray, width: 0.5)
        sideMenuView.parkingPassView.layer.addBorder([.bottom], color: .lightGray, width: 1)
    }
    
    
    // MARK: - Selectors
    
    // backView 탭하면 사이드메뉴가 접힘.
    @objc func backViewDidTap() {
        sideMenuButtonDidTap()
    }
    
    @objc func sideMenuButtonDidTap() {
        var x: CGFloat = 0
        var alpha: CGFloat = 0.0
        
            // 사이드메뉴 펼쳐짐
        if sideMenuButton.tag == -1 {
            alpha = 0.7
            x = sideMenuView.frame.width
            backView.isHidden = false
            sideMenuButton.tag = 0
            
            // 사이드메뉴 접힘
        } else {
            alpha = 0.0
            x = sideMenuView.frame.width * -1
            backView.isHidden = true
            sideMenuButton.tag = -1
        }
        
        UIView.animate(withDuration: 0.3) {
            self.sideMenuView.frame.origin.x += x
            self.backView.backgroundColor = UIColor.black.withAlphaComponent(alpha)
        }
        
    }
    
    @objc func handleLeftEdgeGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let delta = sender.translation(in: self.view)
        let sideMenuWidth = view.frame.width - 100
        
        if sender.state == .changed {
             if -sideMenuWidth + delta.x <= 0 {
                sideMenuButton.tag = 0
                sideMenuView.frame.origin.x = -sideMenuWidth + delta.x
                
                let alpha = (7 - (sideMenuView.frame.origin.x / (-sideMenuWidth / 7))) * 0.1
                backView.isHidden = false
                backView.backgroundColor = UIColor.black.withAlphaComponent(alpha)
            }
        } else if sender.state == .ended {
            if sideMenuView.frame.origin.x > -(view.frame.width - 100) / 2 { // 절반이상 이동됨 -> 사이드메뉴 열림.
                sideMenuButton.tag = 0 // 0: 사이드메뉴 열림
                animateSideMenuView(to: sideMenuView, alpha: 0.7, isHidden: false)
            } else { // 절반 이하 이동됨 -> 사이드메뉴 접힘
                sideMenuButton.tag = -1 // -1: 사이드메뉴 접힘
                animateSideMenuView(to: sideMenuView, point: CGPoint(x: -(view.frame.width - 100), y: 0.0), alpha: 0.0, isHidden: true)
            }
        }
    }
    
    @objc func searchButtonDidTap() {
        let searchViewController = SearchViewController()
        title = ""
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = KAMainColor
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
        view.addSubview(backView)
        view.addSubview(sideMenuView)
        view.addSubview(edgeView)
        
        filterView.delegate = self
        settingBarView.delegate = self
        
        let sideMenuViewWidth = view.frame.width - 100
        sideMenuView.delegate = self
        
        locationView.anchor(top: settingBarView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        mapView.anchor(top: locationView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        filterView.anchor(top: settingBarView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: -260, height: 260)
        settingBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        sideMenuView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor,
                            paddingLeft: -sideMenuViewWidth, width: view.frame.width - 100)
        backView.addConstraintsToFillView(view)
        edgeView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, width: 10)
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
    
    func moveView(to: UIView, time: TimeInterval = 0.3, point: CGPoint = CGPoint(x: 0.0, y: 0.0), alpha: CGFloat, isHidden: Bool) {
        UIView.animate(withDuration: time, animations: {
            to.frame.origin.x = point.x
            self.backView.backgroundColor = UIColor.black.withAlphaComponent(alpha)
        }, completion: { isFinished in
            self.backView.isHidden = isHidden
        })
    }
    
    func animateSideMenuView(to: UIView, point: CGPoint = CGPoint(x: 0.0, y: 0.0), alpha: CGFloat, isHidden: Bool) {
        UIView.animate(withDuration: 0.3) {
            to.frame.origin.x = point.x
            self.backView.backgroundColor = UIColor.black.withAlphaComponent(alpha)
        } completion: { _ in
            self.backView.isHidden = isHidden
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

// MARK: - SideMenuViewDelegate

extension MainViewController: SideMenuViewDelegate {
    
    func moveView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func didSwipe(view: UIView, recognizer: UIPanGestureRecognizer) {
        
        let delta = recognizer.translation(in: self.view)
        
        if recognizer.state == .changed {
            if view.frame.origin.x + delta.x <= 0, delta.x <= 0 {
                sideMenuButton.tag = 0
                view.frame.origin.x = delta.x
                backView.isHidden = false
                
                let alpha = (7 - (view.frame.origin.x / -(view.frame.width / 7))) * 0.1 // 사이드 메뉴를 밀어 넣으면서 backView의 알파 값이 변경
                backView.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(alpha))
            }
            
        } else if recognizer.state == .ended {
            if view.frame.origin.x > -view.frame.width / 2 { // 절반 이하 이동된 경우, 사이드 메뉴를 다시 펼침.
                sideMenuButton.tag = 0
                moveView(to: view, alpha: 0.7, isHidden: false)
            } else { // 절반이상 이동된 경우, 사이드 메뉴를 접음.
                sideMenuButton.tag = -1
                moveView(to: view, point: CGPoint(x: -view.frame.width, y: 0.0), alpha: 0.0, isHidden: true)
            }
        }
    }
    
}
