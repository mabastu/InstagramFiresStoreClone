//
//  PostViewModel.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 12/1/22.
//

import UIKit

struct PostViewModel {
    
    private let post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    init(post: Post) {
        self.post = post
    }
    
}
