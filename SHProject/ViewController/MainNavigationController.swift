//
//  MainNavigationController.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let viewController = storyboard?
      .instantiateViewController(withIdentifier: "LoginViewController")
      as? LoginViewController {
      self.pushViewController(viewController, animated: false)
    }
  }
  
  override func popViewController(animated: Bool) -> UIViewController
  {
    // viewWillAppearWithPageIndex
    let childrenCount = self.viewControllers.count
    let toViewController = self.viewControllers[childrenCount - 2] as! ListViewController
    let toView = toViewController.transitionCollectionView()
    let popedViewController = self.viewControllers[childrenCount - 1] as! UICollectionViewController
    let popView  = popedViewController.collectionView!
    let indexPath = popView.fromPageIndexPath()
    toViewController.viewWillAppearWithPageIndex(indexPath.row)
    toView?.setToIndexPath(indexPath)
    return super.popViewController(animated: animated)!
  }
  
}
