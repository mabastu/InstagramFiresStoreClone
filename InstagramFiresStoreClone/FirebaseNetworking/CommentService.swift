//
//  CommentService.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 12/5/22.
//

import UIKit
import Firebase

struct CommentService {
    
    static func uploadComment(comment: String, postId: String, user: User, completion: @escaping(FirestoreCompletion)) {
        
        let data: [String: Any] = [ "uid" : user.uid,
                                    "comment" : comment,
                                    "timestamp" : Timestamp(date: Date()),
                                    "username" : user.username,
                                    "profileImageUrl" : user.profileImageUrl ]
        
        COLLECTION_POSTS.document(postId).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func fetchComments() {
        
    }
}
