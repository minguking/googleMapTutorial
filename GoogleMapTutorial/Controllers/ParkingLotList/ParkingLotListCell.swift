//
//  ParkingLotListCell.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/05.
//

import UIKit

class ParkingLotListCell: UITableViewCell {
    
    // MARK: - Properties
    
    let thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "")
        iv.backgroundColor = .brown
        iv.layer.cornerRadius = 5
        return iv
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
        
        addSubview(thumbnailImageView)
        
        let imageHeight: CGFloat = 105 - 35
        let imageWidth = imageHeight * 1.3
        
        thumbnailImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 15, paddingLeft: 10,
                                  width: imageWidth, height: imageHeight)
    }

}
