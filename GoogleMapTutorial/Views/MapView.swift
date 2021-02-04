//
//  MapView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/04.
//

import UIKit
import GoogleMaps

class MapView: UIView {

    // MARK: - Properties
    
    var mainMapView: GMSMapView!
    
    var location: AnyObject!
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        backgroundColor = .yellow
        
//        addSubview(mainMapView)
    }
    
    func configureMap(location: AnyObject, locationDidSet: Bool = true) {
        self.location = location
        
        let camera = GMSCameraPosition.camera(withLatitude: self.location.coordinate.latitude, longitude: self.location.coordinate.longitude, zoom: 16.0)
        self.mainMapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), camera: camera)
        addSubview(mainMapView)
        
        if locationDidSet {
            mainMapView.isMyLocationEnabled = true
            mainMapView.settings.myLocationButton = true
        } else {
            mainMapView.isMyLocationEnabled = false
            mainMapView.settings.myLocationButton = false
        }
        
    }
    
}
