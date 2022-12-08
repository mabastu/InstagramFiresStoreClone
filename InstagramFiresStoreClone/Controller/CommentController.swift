//
//  CommentController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 12/3/22.
//

import UIKit

class CommentController: UICollectionViewController {
    
    // MARK: - Properties
    
    let reuseId = "commentCell"
    private let post: Post
    private var comments = [Comment]()
    
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentView = CommentInputAccesoryView(frame: frame)
        commentView.delegate = self
        return commentView
    }()
    
    // MARK: - Lifecycle
    
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchComments()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helper
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        navigationItem.title = " Comments"
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseId)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    // MARK: - Network-Call
    
    func fetchComments() {
        CommentService.fetchComments(forPost: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
}


// MARK: - UICollectionViewDataSource

extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = comments[indexPath.row].uid
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height + 20
        return CGSize(width: view.frame.width, height: height)
    }
}

// MARK: - CommentInputAccesoryViewDelegate

extension CommentController: CommentInputAccesoryViewDelegate {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        
        guard let tab = tabBarController as? MainTabController else { return }
        guard let user = tab.user else { return }
        showLoader(true)
        CommentService.uploadComment(comment: comment, postId: post.postId, user: user) { _ in
            self.showLoader(false)
            inputView.clearCommentTextView()
        }
    }
}
