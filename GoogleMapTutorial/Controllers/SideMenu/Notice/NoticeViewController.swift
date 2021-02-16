//
//  NoticeViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/16.
//

import UIKit

private let noticeCellID = "NoticeCellID"

class NoticeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: noticeCellID)
        
        view.addSubview(tableView)
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

}

// MARK: - UITableViewDataSource

extension NoticeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: noticeCellID, for: indexPath) as! NoticeTableViewCell
        
        cell.backgroundColor = .yellow
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension NoticeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
