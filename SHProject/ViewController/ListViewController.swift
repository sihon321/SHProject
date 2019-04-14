//
//  ListViewController.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

enum ListSectionType: Int {
  case user, dashboard
}

class ListViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  let holder = TransitionManager()
  
  var userInfo: UserInfo? = nil
  
  var dashboardInfo: DashboardInfo? = nil
  
  var posts: [PostElement]? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.delegate = holder
    
    AuthService.shared.requestUserInfo { [weak self] (_, userInfo) in
      guard let strongSelf = self else { return }
      strongSelf.userInfo = userInfo
      strongSelf.collectionView.reloadSections(IndexSet([ListSectionType.user.rawValue]))
    }
    
    AuthService.shared.requestDashBoard { [weak self] (_, dashboardInfo) in
      guard let strongSelf = self else { return }
      strongSelf.dashboardInfo = dashboardInfo
      strongSelf.posts = dashboardInfo?.response.posts?.filter { $0.type == .photo }
      strongSelf.collectionView.reloadSections(IndexSet([ListSectionType.dashboard.rawValue]))
    }
    
    collectionView.register(DashboardInfoCell.self)
    collectionView.register(UserInfoCell.self)
  }

}

extension ListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == ListSectionType.dashboard.rawValue {
      let flowLayout = UICollectionViewFlowLayout()
      flowLayout.itemSize = CGSize(width: UIScreen.width,
                                   height: UIScreen.height - 88 - 34)
      
      flowLayout.minimumLineSpacing = 0
      flowLayout.minimumInteritemSpacing = 0
      flowLayout.scrollDirection = .horizontal
      let detailViewController = DetailViewController(data: posts,
                                                      collectionViewLayout: flowLayout,
                                                      currentIndexPath: IndexPath(row: indexPath.row,
                                                                                  section: 0))
      
      collectionView.setToIndexPath(indexPath)
      navigationController!.pushViewController(detailViewController, animated: true)
    }
  }
}

extension ListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    let section = ListSectionType(rawValue: section)!
    switch section {
    case .user:
      return 1
    case .dashboard:
      return posts?.count ?? 0
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let section = ListSectionType(rawValue: indexPath.section)!
    
    switch section {
    case .user:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserInfoCell.reuseIdentifier,
                                                    for: indexPath) as! UserInfoCell
      cell.config(userInfo)
      return cell
    case .dashboard:
      let postInfo = posts?[indexPath.row]
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardInfoCell.reuseIdentifier,
                                                    for: indexPath) as! DashboardInfoCell
      cell.config(postInfo)
      return cell
    }
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let section = ListSectionType(rawValue: indexPath.section)!
    
    switch section {
    case .user:
      return UserInfoCell.size()
    case .dashboard:
      return DashboardInfoCell.size()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    guard let sectionType = ListSectionType(rawValue: section) else {
      return .zero
    }
    switch sectionType {
    case .user:
      return .zero
    case .dashboard:
      return UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
    }
  }
}

extension ListViewController: TransitionProtocol {
  func transitionCollectionView() -> UICollectionView! {
    return collectionView
  }
  
  func viewWillAppearWithPageIndex(_ pageIndex: NSInteger) {
    var position = UICollectionView
      .ScrollPosition
      .centeredHorizontally
      .intersection(.centeredVertically)
    let dashIndexPath = IndexPath(row: pageIndex, section: 1)
    let cell = collectionView.cellForItem(at: dashIndexPath) as? DashboardInfoCell
    let height = cell?.bounds.height ?? 0.0
    
    if height > 400.0 {
      position = .top
    }

    let collectionView = self.collectionView!;
    collectionView.setToIndexPath(dashIndexPath)
    if pageIndex < 2 {
      collectionView.setContentOffset(CGPoint.zero, animated: false)
    } else {
      collectionView.scrollToItem(at: dashIndexPath, at: position, animated: false)
    }
  }
}
