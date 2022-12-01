//
//  AuthenticationService.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/9/22.
//

import UIKit
import Firebase

struct AuthenticationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthenticationService {
    static func logUserIn(email: String, password: String, completion: @escaping(AuthDataResult? ,Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredentilas credentials: AuthenticationCredentials, completion: @escaping(Error?) -> Void) {
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("Failed to register user \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = [ "email" : credentials.email,
                                            "fullname" : credentials.fullname,
                                            "profileImage" : imageURL,
                                            "uid" : uid,
                                            "username" : credentials.username
                ]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
}
