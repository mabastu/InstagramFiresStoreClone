//
//  UserCell.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/14/22.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: UserCellViewModel? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let fullname: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        username.text = viewModel.username
        fullname.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
