//
//  DisappearAnimatedTransitioning.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class DisappearAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.35
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromViewController = transitionContext.viewController(forKey: .from),
      let toViewController = transitionContext.viewController(forKey: .to),
      let listView = toViewController as? ListViewController,
      let pageView = fromViewController as? DetailViewController else {
        debugPrint("""
          Error DisappearAnimatedTransitioning ViewController
          from: \(String(describing: transitionContext.viewController(forKey: .from)))
          to: \(String(describing: transitionContext.viewController(forKey: .to)))
          """)
        return
    }
    
    guard let toView = toViewController.view else {
      debugPrint("""
        Error DisappearAnimatedTransitioning View
        from: \(String(describing: fromViewController.view))
        to: \(String(describing: fromViewController.view))
        """)
      return
    }
    
    let containerView = transitionContext.containerView
    
    containerView.addSubview(toView)
    toView.isHidden = true
    
    listView.collectionView.layoutIfNeeded()
    let indexPath = (pageView.collectionView?.fromPageIndexPath())!
    let gridView = listView.collectionView.cellForItem(at: IndexPath(row: indexPath.row, section: 1))
    let leftUpperPoint = gridView!.convert(CGPoint.zero, to: toViewController.view)
    
    let animationScale = UIScreen.width / (UIScreen.width / 2 - 5.0)
    let snapShot = (gridView as! DashboardInfoCell).snapShot()
    snapShot?.transform = CGAffineTransform(scaleX: animationScale,
                                            y: animationScale)
    let offsetY: CGFloat = 88.0
    snapShot?.origin(CGPoint(x: 0, y: offsetY))
    containerView.addSubview(snapShot!)
    
    toView.isHidden = false
    toView.alpha = 0
    toView.transform = (snapShot?.transform)!
    toView.frame = CGRect(x: -(leftUpperPoint.x * animationScale),
                          y: -((leftUpperPoint.y-offsetY) * animationScale+offsetY),
                          width: toView.frame.size.width,
                          height: toView.frame.size.height)
    
    let whiteViewContainer = UIView(frame: UIScreen.main.bounds)
    whiteViewContainer.backgroundColor = UIColor.white
    containerView.addSubview(snapShot!)
    containerView.insertSubview(whiteViewContainer, belowSubview: toView)
    
    UIView.animate(withDuration: 0.35, animations: {
      snapShot?.transform = CGAffineTransform.identity
      snapShot?.frame = CGRect(x: leftUpperPoint.x, y: leftUpperPoint.y, width: (snapShot?.frame.size.width)!, height: (snapShot?.frame.size.height)!)
      toView.transform = CGAffineTransform.identity
      toView.frame = CGRect(x: 0, y: 0, width: toView.frame.size.width, height: toView.frame.size.height);
      toView.alpha = 1
    }, completion:{finished in
      if finished {
        snapShot?.removeFromSuperview()
        whiteViewContainer.removeFromSuperview()
        transitionContext.completeTransition(true)
      }
    })
  }
}
