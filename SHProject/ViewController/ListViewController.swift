//
//  ListViewController.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  let gridWidth: CGFloat = (UIScreen.main.bounds.size.width / 2) - 5.0
  var colorList: [UIColor] = [.blue, .black, .orange, .yellow, .cyan, .gray, .green, .purple, .magenta, .red]
  let holder = TransitionManager()
  var userInfo: UserInfo? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.delegate = holder
    
    AuthService.shared.requestUserInfo { [weak self] (_, userInfo) in
      guard let strongSelf = self else { return }
      strongSelf.userInfo = userInfo
      print(strongSelf.userInfo)
    }
    
    collectionView.register(ListCollectionViewCell.self)
  }

}

extension ListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: UIScreen.width,
                                 height: UIScreen.height - 88 - 34)
    
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.scrollDirection = .horizontal
    let detailViewController = DetailViewController(collectionViewLayout: flowLayout,
                                                    currentIndexPath: indexPath)
    
    collectionView.setToIndexPath(indexPath)
    navigationController!.pushViewController(detailViewController, animated: true)
  }
}

extension ListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return colorList.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseIdentifier,
                                                  for: indexPath) as! ListCollectionViewCell
    
    cell.imageView.backgroundColor = colorList[indexPath.row]
    
    return cell
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: gridWidth, height: 250.0)
  }
  
}

extension ListViewController: TransitionProtocol {
  func transitionCollectionView() -> UICollectionView! {
    return collectionView
  }
}
