//
//  UICollectionView+IndexPath.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

var kIndexPathPointer = "kIndexPathPointer"

enum CollectionViewElementKind: String {
  case header, footer
  fileprivate var stringValue: String {
    switch self {
    case .header:
      return UICollectionView.elementKindSectionHeader
    case .footer:
      return UICollectionView.elementKindSectionFooter
    }
  }
}

extension UICollectionReusableView: NibLoadableView { }

extension UICollectionReusableView: ReusableView { }

extension UICollectionView {
  
  func setToIndexPath (_ indexPath: IndexPath) {
    
    objc_setAssociatedObject(self, &kIndexPathPointer, indexPath,
                             objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  func toIndexPath(sectionType: ListSectionType) -> IndexPath {
    
    let index = self.contentOffset.x / self.frame.size.width
    
    if index > 0 {
      return IndexPath(row: Int(index), section: sectionType.rawValue)
    } else if let indexPath = objc_getAssociatedObject(self,&kIndexPathPointer) as? IndexPath {
      return IndexPath(row: indexPath.row, section: sectionType.rawValue)
    } else {
      return IndexPath(row: 0, section: sectionType.rawValue)
    }
  }
  
  func fromPageIndexPath() -> IndexPath {
    
    let index: Int = Int(self.contentOffset.x / self.frame.size.width)
    return IndexPath(row: index, section: 0)
  }
}

extension UICollectionView {
  
  func register<T: UICollectionViewCell>(_: T.Type) {
    
    let nib = UINib(nibName: T.nibName, bundle: nil)
    register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
  }
  
  func register<T: UIView>(_: T.Type,
                           _ elementKind: CollectionViewElementKind) where T: ReusableView, T: NibLoadableView {
    
    let nib = UINib.init(nibName: T.nibName, bundle: nil)
    register(nib,
             forSupplementaryViewOfKind: elementKind.stringValue,
             withReuseIdentifier: T.reuseIdentifier)
  }
}


