//
//  MainTabController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/6/22.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(with: user)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        tabBarConfiguration()
        checkIfUserIsLogin()
    }
    
    // MARK: - Network Call
    
    func checkIfUserIsLogin() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true)
            }
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.fetchUser(withUid: uid) { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
    
    // MARK: - Helpers
    
    func tabBarConfiguration() {
        if #available(iOS 15.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    func configureViewControllers(with user: User) {
        
        self.delegate = self
        
        let feedFlowLayout = UICollectionViewFlowLayout()
        
        let feed = customNavigationController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), rootViewController: FeedController(collectionViewLayout: feedFlowLayout))
        let search = customNavigationController(unselectedImage: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"), rootViewController: SearchController())
        let imageSelector = customNavigationController(unselectedImage: UIImage(systemName: "plus.square"), selectedImage: UIImage(systemName: "plus.square.fill"), rootViewController: ImageSelectorController())
        let notifications = customNavigationController(unselectedImage: UIImage(systemName: "bubble.left"), selectedImage: UIImage(systemName: "bubble.left.fill"), rootViewController: NotificationsController())
        
        let profileController = ProfileController(user: user)
        let profile = customNavigationController(unselectedImage: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"), rootViewController: profileController)
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
    }
    
    func customNavigationController(unselectedImage: UIImage!, selectedImage: UIImage!, rootViewController: UIViewController) -> UINavigationController {
        
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        
        return navigation
    }
    
    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                let controller = UploadPostController()
                controller.delegate = self
                controller.selectedImage = selectedImage
                controller.currentUser = self.user
                let navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true)
            }
        }
    }
    
}


extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        self.dismiss(animated: true)
        fetchUser()
    }
}

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
           var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true)
            
            didFinishPickingMedia(picker)
        }
        return true
    }
}

extension MainTabController: UploadPostControllerDelegate {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true)
        
        guard let feedNavigation = viewControllers?.first as? UINavigationController else { return }
        guard let feed = feedNavigation.viewControllers.first as? FeedController else { return }
        feed.refreshFeed()
    }
}
