//
//  AuthenticationViewModel.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/8/22.
//

import UIKit

struct ViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var loginFormIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false
    }
    
    var signupFormIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
}
