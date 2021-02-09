//
//  SideMenuView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/08.
//

import UIKit

private let sideMenuCellID = "SideMenuCellID"

protocol SideMenuViewDelegate: class {
    func didSwipe(view: UIView, recognizer: UIPanGestureRecognizer)
}

class SideMenuView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: SideMenuViewDelegate?
    
    lazy var recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = KAMainColor
        return view
    }()
    
    let mobileTicketView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let parkingPassView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let tableView = UITableView()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
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
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        delegate?.didSwipe(view: self, recognizer: recognizer)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        backgroundColor = .white
        
        gestureRecognizers = [recognizer]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: sideMenuCellID)
        tableView.bounces = false
        tableView.separatorStyle = .none
        
        addSubview(mainView)
        mainView.addSubview(topView)
        mainView.addSubview(mobileTicketView)
        mainView.addSubview(parkingPassView)
        mainView.addSubview(tableView)
        mainView.addSubview(bottomView)
        
        let mainViewWidth = UIScreen.main.bounds.size.width - 100
        
        mainView.addConstraintsToFillView(self)
        topView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, height: 110)
        mobileTicketView.anchor(top: topView.bottomAnchor, left: mainView.leftAnchor, width: mainViewWidth / 2, height: mainViewWidth / 3)
        parkingPassView.anchor(top: topView.bottomAnchor, left: mobileTicketView.rightAnchor, width: mainViewWidth / 2, height: mainViewWidth / 3)
        tableView.anchor(top: mobileTicketView.bottomAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor,
                         paddingBottom: 100)
        bottomView.anchor(left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, height: 100)
    }

}


extension SideMenuView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuCellID, for: indexPath) as! SideMenuCell
        
        return cell
    }
    
}

extension SideMenuView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
