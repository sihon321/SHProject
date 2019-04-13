//
//  DetailCollectionViewController.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class DetailViewController: UICollectionViewController {
  
  var colorList: [UIColor] = [.blue, .black, .orange, .yellow, .cyan, .gray, .green, .purple, .magenta, .red]
  
  var posts: [PostElement]? = nil
  
  init(data: [PostElement]?,
       collectionViewLayout layout: UICollectionViewLayout,
       currentIndexPath indexPath: IndexPath) {
    super.init(collectionViewLayout:layout)

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
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts?.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let post = posts?[indexPath.row]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reuseIdentifier,
                                                  for: indexPath) as! DetailCollectionViewCell
    cell.config(post)
    cell.setNeedsLayout()
    return cell
  }
}

extension DetailViewController: TransitionProtocol {
  func transitionCollectionView() -> UICollectionView! {
    return collectionView
  }
}


