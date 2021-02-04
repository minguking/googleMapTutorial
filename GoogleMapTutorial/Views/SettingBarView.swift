//
//  SettingBarView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/04.
//

import UIKit

protocol SettingBarViewDelegate: class {
    func listButtonDidTap()
}

class SettingBarView: UIView {

    // MARK: - Properties
    
    weak var delegate: SettingBarViewDelegate?
    
    let filterImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_search_filter")
        iv.highlightedImage = UIImage(named: "ic_search_filter_pressed")
        iv.setDimensions(width: 40, height: 40)
        iv.tintColor = .white
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "시간주차 / 1시간 기준 요금"
        label.textColor = .white
        return label
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(listButtonDidTap), for: .touchUpInside)
        button.setImage(UIImage(named: "ic_action_list"), for: .normal)
        button.setImage(UIImage(named: "ic_action_list_pressed"), for: .highlighted)
        button.tintColor = .white
        button.setDimensions(width: 40, height: 40)
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
    
    @objc func listButtonDidTap() {
        delegate?.listButtonDidTap()
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        backgroundColor = .systemPurple
        
        addSubview(filterImageView)
        addSubview(listButton)
        
        filterImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 20)
        listButton.centerY(inView: self)
        listButton.anchor(right: rightAnchor, paddingRight: 16)
    }

}
