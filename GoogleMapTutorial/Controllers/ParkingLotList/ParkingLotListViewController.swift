//
//  ParkingLotListViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/05.
//

import UIKit

private let reuseIdentifier = "CellID"

class ParkingLotListViewController: UIViewController {
    
    // MARK: - Properties
    
    let headerView = ParkingLotListHeaderView()
    
    var sortType: Int = 1
    /**
     sortType
        1: Price
        2: Distance
     */
    
    let tableView = UITableView()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "주차장 리스트"
        
        view.addSubview(headerView)
        headerView.delegate = self
        view.addSubview(tableView)
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.isHidden = true
        tableView.register(ParkingLotListCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        tableView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }

}

// MARK: - ParkingLotListHeaderViewDelegate

extension ParkingLotListViewController: ParkingLotListHeaderViewDelegate {
    
    func sortButtonDidTap(_ sender: UIButton) {
        sortType = sender.tag
        
        print("DEBUG: sortType  = \(sortType)")
    }
    
}

// MARK: - UITableViewDataSource

extension ParkingLotListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ParkingLotListCell
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ParkingLotListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}
