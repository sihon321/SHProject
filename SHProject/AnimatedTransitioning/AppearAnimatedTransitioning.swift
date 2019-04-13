//
//  AppearAnimatedTransitioning.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class AppearAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.15
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromViewController = transitionContext.viewController(forKey: .from),
      let toViewController = transitionContext.viewController(forKey: .to),
      let listView = fromViewController as? ListViewController,
      let pageView = toViewController as? DetailViewController else {
        debugPrint("""
          Error AppearAnimatedTransitioning ViewController
          from: \(String(describing: transitionContext.viewController(forKey: .from)))
          to: \(String(describing: transitionContext.viewController(forKey: .to)))
          """)
        return
    }
    
    guard let fromView = fromViewController.view,
      let toView = toViewController.view else {
        debugPrint("""
          Error AppearAnimatedTransitioning View
          from: \(String(describing: fromViewController.view))
          to: \(String(describing: toViewController.view))
          """)
        return
    }
    
    let containerView = transitionContext.containerView
    
    containerView.addSubview(fromView)
    containerView.addSubview(toView)
    
    let indexPath = listView.collectionView.toIndexPath(sectionType: .dashboard)
    let gridView = listView.collectionView.cellForItem(at: indexPath as IndexPath)
    
    let navigationPoint = CGPoint(x: 0.0,
                                  y: 88.0)
    let leftUpperPoint = gridView!.convert(navigationPoint, to: nil)
    pageView.collectionView?.isHidden = true
    pageView.collectionView?.scrollToItem(at: IndexPath(row: indexPath.row,
                                                        section: 0),
                                         at:.centeredHorizontally,
                                         animated: false)
    
    let snapShot = (gridView as! DashboardInfoCell).snapShot()
    containerView.addSubview(snapShot!)
    snapShot?.origin(leftUpperPoint)
    
    UIView.animate(withDuration: 0.35, animations: {
      let animationScale = UIScreen.width / (UIScreen.width / 2 - 5.0)
      snapShot?.transform = CGAffineTransform(scaleX: animationScale,
                                              y: animationScale)
      snapShot?.frame = CGRect(x: 0, y: 88.0,
                               width: (snapShot?.frame.size.width)!,
                               height: (snapShot?.frame.size.height)!)
      
      fromView.alpha = 0
      fromView.transform = (snapShot?.transform)!
      fromView.frame = CGRect(x: -(leftUpperPoint.x) * animationScale,
                              y: -(leftUpperPoint.y - UIScreen.statusBarHeight)
                                * animationScale + UIScreen.statusBarHeight,
                              width: fromView.frame.size.width,
                              height: fromView.frame.size.height)
    }, completion: { finished in
      if finished {
        snapShot?.removeFromSuperview()
        pageView.collectionView?.isHidden = false
        fromView.transform = CGAffineTransform.identity
        transitionContext.completeTransition(true)
      }
    })
  }
  
}
