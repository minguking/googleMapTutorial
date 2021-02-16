//
//  QuestionViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/16.
//

import UIKit

private let QNACellID = "QNACellID"

class QNAViewController: UIViewController {
    
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
        
        title = "묻고 답하기"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(QNATableViewCell.self, forCellReuseIdentifier: QNACellID)
        
        view.addSubview(tableView)
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

}


// MARK: - UITableViewDataSource

extension QNAViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QNACellID, for: indexPath) as! QNATableViewCell
        
//        cell.backgroundColor = .brown
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension QNAViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
