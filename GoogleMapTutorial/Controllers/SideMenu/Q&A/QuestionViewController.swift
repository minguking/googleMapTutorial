//
//  QuestionViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/16.
//

import UIKit

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
        
        view.addSubview(tableView)
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

}
