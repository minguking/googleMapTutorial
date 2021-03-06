//
//  FilterView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/05.
//

import UIKit

protocol FilterViewDelegate: class {
    func dragButtonDidTap()
    func didScroll(view: UIView, recognizer: UIPanGestureRecognizer)
}

class FilterView: UIView {

    // MARK: - Properties
    
    weak var delegate: FilterViewDelegate?
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let dragView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let dragButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "bt_search_updown"), for: .normal)
        button.addTarget(self, action: #selector(dragButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    @objc func dragButtonDidTap() {
        delegate?.dragButtonDidTap()
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        delegate?.didScroll(view: self, recognizer: sender)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        addSubview(dragView)
        dragView.addSubview(dragButton)
        addSubview(mainView)
        
        gestureRecognizers = [recognizer]
        
        dragView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 30)
        dragButton.centerX(inView: dragView)
        dragButton.anchor(width: 60, height: 30)
        mainView.anchor(top: topAnchor, left: leftAnchor, bottom: dragView.topAnchor, right: rightAnchor)
    }

}
