//
//  UICollectionView+IndexPath.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

var kIndexPathPointer = "kIndexPathPointer"

extension UICollectionReusableView: NibLoadableView { }

extension UICollectionReusableView: ReusableView { }

extension UICollectionView {
  
  func setToIndexPath (_ indexPath: IndexPath){
    objc_setAssociatedObject(self, &kIndexPathPointer, indexPath,
                             objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  func toIndexPath () -> IndexPath {
    let index = self.contentOffset.x / self.frame.size.width
    
    if index > 0 {
      return IndexPath(row: Int(index), section: 0)
    } else if let indexPath = objc_getAssociatedObject(self,&kIndexPathPointer) as? IndexPath {
      return indexPath
    } else {
      return IndexPath(row: 0, section: 0)
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
}


