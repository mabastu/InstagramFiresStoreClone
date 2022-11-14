//
//  ProfileHeader.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/10/22.
//

import UIKit
import SDWebImage

class ProfileHader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedTextLabel(value: 9, label: "Posts")
        return label
    }()
    
    private lazy var followersNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedTextLabel(value: 182, label: "Followers")
        return label
    }()
    
    private lazy var followingNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedTextLabel(value: 1, label: "Following")
        return label
    }()
    
    private let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.grid.3x3"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    // MARK: - Actions
    
    @objc private func editProfileTapped() {
        
    }
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 24, paddingRight: 24)
        
        let stackView = UIStackView(arrangedSubviews: [postNumberLabel, followersNumberLabel, followingNumberLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.centerY(inView: profileImageView)
        stackView.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
        
        let topDevider = UIView()
        topDevider.backgroundColor = .lightGray
        
        let bottomDevider = UIView()
        topDevider.backgroundColor = .lightGray
        
        let buttonStackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        addSubview(topDevider)
        addSubview(bottomDevider)
        
        buttonStackView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        topDevider.anchor(top: buttonStackView.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        bottomDevider.anchor(top: buttonStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    // MARK: - Helpers
    
    func attributedTextLabel(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor.lightGray]))
        return attributedText
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
