//
//  Comment.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 12/8/22.
//

import Foundation
import Firebase

struct Comment {
    let uid: String
    let username: String
    let timestamp: Timestamp
    let profileImageUrl: String
    let commentText: String
    
    init(dictionary: [String : Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.commentText = dictionary["comment"] as? String ?? ""
    }
}
