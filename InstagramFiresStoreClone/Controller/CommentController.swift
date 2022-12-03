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
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    // MARK: - Helper
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        navigationItem.title = " Comments"
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseId)
    }
}


// MARK: - UICollectionViewDataSource

extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}
