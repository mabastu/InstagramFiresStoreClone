//
//  UserCell.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/14/22.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "venom-7"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Venom"
        return label
    }()
    
    private let fullname: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "I'm Venom"
        label.textColor = .lightGray
        return label
    }()
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let labelesStackView = UIStackView(arrangedSubviews: [username, fullname])
        labelesStackView.axis = .vertical
        labelesStackView.spacing = 4
        labelesStackView.alignment = .leading
        
        addSubview(labelesStackView)
        labelesStackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
