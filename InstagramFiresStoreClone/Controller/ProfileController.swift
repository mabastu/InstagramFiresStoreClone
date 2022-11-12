//
//  ProfileController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/6/22.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    let profileCellID = "profileCellID"
    let profileHeaderID = "profileHeaderID"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerCollectionView()
        view.backgroundColor = .systemMint
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Helper
    
    func configerCollectionView() {
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellID)
        collectionView.register(ProfileHader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderID)
    }
    
}

// MARK: - UICollectionViewDataSource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellID, for: indexPath) as! ProfileCell
        cell.backgroundColor = .blue
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: profileHeaderID, for: indexPath) as! ProfileHader
        return header
    }
    
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthAndHeiht = (view.frame.width - 2) / 3
        return CGSize(width: widthAndHeiht, height: widthAndHeiht)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 240)
    }
}
