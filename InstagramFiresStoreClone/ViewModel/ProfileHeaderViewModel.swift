//
//  ProfileHeaderViewModel.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/14/22.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedTextLabel(value: user.stats.followers, label: "Followers")
    }
    
    var numberOfFollowings: NSAttributedString {
        return attributedTextLabel(value: user.stats.following, label: "Following")
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedTextLabel(value: user.stats.posts, label: "Posts")
    }
    
    init(user: User) {
        self.user = user
    }
    
    func attributedTextLabel(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor.lightGray]))
        return attributedText
    }
}
