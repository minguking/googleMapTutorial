//
//  SettingBarView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/04.
//

import UIKit

protocol SettingBarViewDelegate: class {
    func listButtonDidTap()
    func filterDidTap(view: UIView)
}

class SettingBarView: UIView {
    
    /**
        tag = 0 : 필터 접힘
        tag = -1 : 필터 펼쳐짐
     */

    // MARK: - Properties
    
    weak var delegate: SettingBarViewDelegate?
    
    let filterImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_search_filter")
        iv.highlightedImage = UIImage(named: "ic_search_filter_pressed")
        iv.setDimensions(width: 40, height: 40)
        iv.tintColor = .white
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "시간주차 / 1시간 기준 요금" // 정리 필요,,,
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
    
    lazy var recognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        return recognizer
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
        print("DEBUG: current tag = \(tag)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    @objc func viewDidTap() {
        if tag == 0 {
            tag = -1
        } else {
            tag = 0
        }
        
        delegate?.filterDidTap(view: self)
    }
    
    @objc func listButtonDidTap() {
        delegate?.listButtonDidTap()
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        backgroundColor = KAMainColor
        
        addGestureRecognizer(recognizer)
        addSubview(filterImageView)
        addSubview(titleLabel)
        addSubview(listButton)
        
        filterImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 20)
        titleLabel.centerY(inView: self, leftAnchor: filterImageView.rightAnchor, paddingLeft: 20)
        listButton.centerY(inView: self, rightAncher: rightAnchor, paddingRight: 16)
    }

}
