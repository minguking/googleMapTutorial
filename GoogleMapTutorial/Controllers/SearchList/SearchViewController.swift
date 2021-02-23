//
//  SearchViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/08.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    override func configureUI() {
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "검 색"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    
}
