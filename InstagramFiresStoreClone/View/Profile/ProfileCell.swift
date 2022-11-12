//
//  ProfileCell.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/10/22.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var postImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "venom-7"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
}
