//
//  ProfileController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/6/22.
//

import UIKit
import Firebase

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    let profileCellID = "profileCellID"
    let profileHeaderID = "profileHeaderID"
    
    private var user: User
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerCollectionView()
        view.backgroundColor = .systemMint
        collectionView.dataSource = self
        collectionView.delegate = self
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    // MARK: - Network Call
    
    func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @objc func logOut() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true)
        } catch {
            print("Faild to sign out!")
        }
    }
    
    // MARK: - Helper
    
    func configerCollectionView() {
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellID)
        collectionView.register(ProfileHader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderID)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOut))
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
        header.delegate = self
        header.viewModel = ProfileHeaderViewModel(user: user)
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

// MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHader, didTapActionButtonFor user: User) {
        if user.isCurrentUser {
            print("Show edit profile here..")
        } else if user.isFollowed {
            UserService.unfollow(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        } else {
            UserService.follow(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
}
