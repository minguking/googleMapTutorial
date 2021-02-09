//
//  ParkingLotListHeaderView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/05.
//

import UIKit

protocol ParkingLotListHeaderViewDelegate: class {
    func sortButtonDidTap(_ sender: UIButton)
}

class ParkingLotListHeaderView: UIView {

    // MARK: - Properties
    
    weak var delegate: ParkingLotListHeaderViewDelegate?
    
    lazy var priceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "radio_check_off"), for: .normal)
        button.setImage(UIImage(named: "radio_check_on"), for: .selected)
        button.setTitle("가격순", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(KAMainColor, for: .selected)
        button.tag = 1
        button.isSelected = true
        button.setDimensions(width: 60, height: 40)
        button.addTarget(self, action: #selector(sortButtonDidTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    private let distanceButton: UIButton = {
        let button = UIButton(type: .custom) // custom or none 으로 진행,,,
        button.setImage(UIImage(named: "radio_check_off"), for: .normal)
        button.setImage(UIImage(named: "radio_check_on"), for: .selected)
        button.setTitle("거리순", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(KAMainColor, for: .selected)
        button.tag = 2
        button.setDimensions(width: 60, height: 40)
        button.addTarget(self, action: #selector(sortButtonDidTap(sender:)), for: .touchUpInside)
        return button
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
    
    @objc func sortButtonDidTap(sender: UIButton) {
        if sender.tag == 1 {
            priceButton.isSelected = true
            distanceButton.isSelected = false
        } else {
            priceButton.isSelected = false
            distanceButton.isSelected = true
        }
        delegate?.sortButtonDidTap(sender)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        backgroundColor = .systemGroupedBackground
        
        addSubview(distanceButton)
        addSubview(priceButton)
        
        distanceButton.centerY(inView: self, rightAncher: rightAnchor, paddingRight: 20)
        priceButton.centerY(inView: self, rightAncher: distanceButton.leftAnchor, paddingRight: 10)
        
    }

}
