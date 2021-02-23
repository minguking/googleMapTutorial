//
//  FAQViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/16.
//

import UIKit

private let FAQCellID = "FAQCellID"

class FAQViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    override func configureUI() {
        
        title = "자주 묻는 질문"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(FAQTableViewCell.self, forCellReuseIdentifier: FAQCellID)
        
        view.addSubview(tableView)
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}

// MARK: - UITableViewDataSource

extension FAQViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FAQCellID, for: indexPath) as! FAQTableViewCell
        
        cell.backgroundColor = .yellow
        
        return cell
    }
    
}

// MARK: - UITableViewDataSource

extension FAQViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
