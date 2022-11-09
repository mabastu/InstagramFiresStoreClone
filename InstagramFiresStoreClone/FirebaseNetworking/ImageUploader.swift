//
//  ImageUploader.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/9/22.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let fileName = NSUUID().uuidString
        let referance = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        referance.putData(imageData) { metadata, error in
            if let error = error {
                print("Failed to upload image. \(error.localizedDescription)")
                return
            }
            
            referance.downloadURL { url, error in
                guard let imageURL = url?.absoluteString else { return }
                completion(imageURL)
            }
        }
    }
}

