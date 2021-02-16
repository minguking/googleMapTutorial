//
//  QNATableViewCell.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/16.
//

import UIKit

class QNATableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        
    }

}
