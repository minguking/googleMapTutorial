//
//  NoticeTableViewCell.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/16.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.text = "항공지사항공지사항공지사항공지사항공지사항공"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .right
        label.text = "2021-02-16"
        return label
    }()
    
    
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
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        titleLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 15)
        titleLabel.anchor(right: rightAnchor, paddingRight: 125)
        dateLabel.centerY(inView: self, rightAncher: rightAnchor, paddingRight: 20)
        
    }

}
