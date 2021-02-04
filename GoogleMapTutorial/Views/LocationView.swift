//
//  LocationView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/04.
//

import UIKit

class LocationView: UIView {

    // MARK: - Properties
    
    let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_search_placeholder")
        iv.setDimensions(width: 40, height: 40)
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "서울시 영등포구 양평동"
        return label
    }()
    
    
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
        
        backgroundColor = .white
        
        addSubview(locationImageView)
        addSubview(titleLabel)
        
        locationImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 20)
        titleLabel.centerY(inView: self, leftAnchor: locationImageView.rightAnchor, paddingLeft: 20)
        titleLabel.anchor(right: rightAnchor)
    }

}
