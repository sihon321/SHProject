//
//  TransitionManager.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

final class TransitionManager: NSObject {
  
}

extension TransitionManager: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationController.Operation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
    switch operation {
    case .push:
      return AppearAnimatedTransitioning()
    case .pop:
      return DisappearAnimatedTransitioning()
    case .none:
      return nil
    }
  }
}
