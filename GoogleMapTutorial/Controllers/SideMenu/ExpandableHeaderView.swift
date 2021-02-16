//
//  ExpandableHeaderView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/15.
//

import UIKit

protocol ExpandableHeaderViewDelegate: class {
    func toggleSection(header: UITableViewHeaderFooterView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {

    // MARK: - Properties
    
    weak var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 30, height: 30)
        return iv
    }()
    
    lazy var recognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(sectionDidTap))
        return tap
    }()
    
    
    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    @objc func sectionDidTap() {
        print("DEBUG: header tapped...")
//        let headerCell = recognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: section)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        addGestureRecognizer(recognizer)
        
        let view = self.contentView
        
        view.backgroundColor = .white
        
        view.addSubview(arrowImageView)
        
        arrowImageView.centerY(inView: view, rightAncher: view.rightAnchor, paddingRight: 10)
    }
    
    func config(title: String, section: Int, image: UIImage, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
        self.arrowImageView.image = image
    }

}
