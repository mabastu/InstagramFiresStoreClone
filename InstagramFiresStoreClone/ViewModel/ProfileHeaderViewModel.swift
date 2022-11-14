//
//  ProfileHeaderViewModel.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/14/22.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}
