//
//  DetailCollectionViewController.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class DetailViewController: UICollectionViewController {
  
  weak var delegate: ListViewDelegate?
  
  private var posts: [PostElement] = []
  
  private var avatarImages: [String: UIImage] = [:]
  
  init(data: [PostElement],
       collectionViewLayout layout: UICollectionViewLayout,
       currentIndexPath indexPath: IndexPath) {
    super.init(collectionViewLayout:layout)
    
    view.backgroundColor = .white
    collectionView.backgroundColor = .white
    posts = data
    collectionView.isPagingEnabled = true
    collectionView.register(DetailCollectionViewCell.self)
    
    collectionView.setToIndexPath(IndexPath(row: indexPath.row, section: 0))
    collectionView.performBatchUpdates({collectionView.reloadData()}, completion: { finished in
      if finished {
        self.collectionView.scrollToItem(at: indexPath,at:.centeredHorizontally, animated: false)
      }});
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  private func fetchAvatarImage(_ id: String?, _ indexPath: IndexPath) {
    
    if let id = id, avatarImages[id] == nil {
      BlogService.shared.requestAvatar(id, size: 64) { [weak self] image in
        self?.avatarImages[id] = image
        self?.collectionView.reloadItems(at: [indexPath])
      }
    }
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reuseIdentifier,
                                                  for: indexPath) as! DetailCollectionViewCell
    if let id = posts[indexPath.row].blog?.name {
      fetchAvatarImage(id, indexPath)
      cell.config(posts[indexPath.row], avatarImages[id])
    }
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.x + UIScreen.width
      >= scrollView.contentSize.width {
      delegate?.requestMoreData(posts.count) { [weak self] (isSuccess, posts) in
        guard let strongSelf = self, let morePosts = posts else { return }
        strongSelf.posts += morePosts
        strongSelf.collectionView.reloadData()
      }
    }
  }
}

extension DetailViewController: TransitionProtocol {
  func transitionCollectionView() -> UICollectionView! {
    return collectionView
  }
}


