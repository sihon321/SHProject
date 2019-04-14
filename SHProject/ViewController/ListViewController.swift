//
//  ListViewController.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

protocol ListViewDelegate: class {
  func requestMoreData(_ index: Int,
                       _ completion: @escaping (Bool, [PostElement]?) -> Void)
}

extension ListViewController: ListViewDelegate {
  func requestMoreData(_ index: Int, _ completion: @escaping (Bool, [PostElement]?) -> Void) {
    
    fetchDashBoard(offset, index) { (isSuccess, posts) in
      completion(isSuccess, posts)
    }
  }
}

enum ListSectionType: Int {
  case user, dashboard
}

class ListViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let holder = TransitionManager()
  
  private var userInfo: UserInfo? = nil
  
  private var posts: [PostElement] = []
  
  private var _offset = 0
  
  private var offset: Int {
    get {
      _offset += 20
      return _offset
    }
  }
  
  private var isMore = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.delegate = holder
    
    AuthService.shared.requestUserInfo { [weak self] (_, userInfo) in
      guard let strongSelf = self else { return }
      strongSelf.userInfo = userInfo
      strongSelf
        .collectionView
        .reloadSections(IndexSet([ListSectionType.user.rawValue]))
    }
    
    fetchDashBoard(offset, 0, nil)
    
    collectionView.register(DashboardInfoCell.self)
    collectionView.register(UserInfoCell.self)
    collectionView.register(ListFooterView.self, .footer)
  }
  
  private func fetchDashBoard(_ offset: Int,
                              _ currentIdx: Int,
                              _ completion: ((Bool, [PostElement]?) -> Void)? = nil) {
    if isMore, currentIdx + 1 >= posts.count {
      AuthService.shared.requestDashBoard(offset) { [weak self] (isSuccess, dashboardInfo) in
        guard isSuccess,
          let strongSelf = self else {
            self?.isMore = false
            completion?(false, nil)
            return
        }
        
        if let photoPosts = dashboardInfo?
          .response.posts?.filter({ $0.type == .photo }) {
          strongSelf.posts += photoPosts
          
          strongSelf
            .collectionView
            .reloadSections(IndexSet([ListSectionType.dashboard.rawValue]))
          
          completion?(true, photoPosts)
        }
      }
    }
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
      detailViewController.delegate = self
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
      return posts.count
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
      let postInfo = posts[indexPath.row]
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardInfoCell.reuseIdentifier,
                                                    for: indexPath) as! DashboardInfoCell
      cell.config(postInfo)
      fetchDashBoard(offset, indexPath.row)
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    
    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                 withReuseIdentifier: ListFooterView.reuseIdentifier,
                                                                 for: indexPath)
    return footer
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
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
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
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int) -> CGSize {
    let section = ListSectionType(rawValue: section)!
    
    switch section {
    case .dashboard:
      if isMore {
        return ListFooterView.size()
      } else {
        return .zero
      }
    default:
      break
    }
    
    return .zero
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
    
    let collectionView = self.collectionView!
    collectionView.setToIndexPath(dashIndexPath)
    if pageIndex < 2 {
      collectionView.setContentOffset(CGPoint.zero, animated: false)
    } else {
      collectionView.scrollToItem(at: dashIndexPath, at: position, animated: false)
    }
  }
}
