//
//  QNATableViewCell.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/16.
//

import UIKit

class QNATableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let seqLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.text = "456"
        label.setDimensions(width: 40, height: 16)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "정기권 문의"
        return label
    }()
    
    let newStatusImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "img_new")
        iv.setDimensions(width: 10, height: 10)
        return iv
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "2021-02-16"
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "작성자: 김**"
        return label
    }()
    
    let privateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "img_lock"), for: .normal)
        button.setTitle("비공개", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.tintColor = .black
        button.isUserInteractionEnabled = false
        button.setDimensions(width: 60, height: 20)
        return button
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "답변\n완료"
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.numberOfLines = 0
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
        
        addSubview(seqLabel)
        addSubview(titleLabel)
        addSubview(newStatusImageView)
        addSubview(dateLabel)
        addSubview(nameLabel)
        addSubview(privateButton)
        addSubview(statusLabel)
        
        seqLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 5)
        titleLabel.anchor(top: topAnchor, left: seqLabel.rightAnchor, paddingTop: 20, paddingLeft: 5)
        newStatusImageView.centerY(inView: titleLabel, leftAnchor: titleLabel.rightAnchor, paddingLeft: 5)
        dateLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, paddingTop: 8)
        nameLabel.centerY(inView: dateLabel, leftAnchor: dateLabel.rightAnchor, paddingLeft: 20)
        privateButton.centerY(inView: dateLabel, leftAnchor: nameLabel.rightAnchor, paddingLeft: 20)
        statusLabel.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor,
                           paddingTop: 15, paddingBottom: 15, paddingRight: 10, width: 40)
        
    }

}
