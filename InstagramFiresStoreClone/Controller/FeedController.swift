//
//  FeedController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/6/22.
//

import UIKit
import Firebase

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let cellID = "feedCell"
    private var posts = [Post]()
    var post: Post?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }
    
    // MARK: - Actions
    
    @objc func refreshFeed() {
        posts.removeAll()
        fetchPosts()
    }
    
    // MARK: - Networking
    
    func fetchPosts() {
        guard post == nil else { return }
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellID)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "instagram-dark-logo")
        imageView.image = image
        
        if post == nil {
            navigationItem.titleView = imageView
        }
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        collectionView.refreshControl = refresher
        
    }
    
}

// MARK: - UICollectionViewDataSource

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FeedCell
        cell.delegate = self
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 110
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - FeedCellDelegate

extension FeedController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowComments for: Post) {
        let controller = CommentController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(controller, animated: true)
    }
}
