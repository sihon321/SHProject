//
//  UIScreen+Size.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

extension UIScreen {
  
  @objc public class var size: CGSize {
    return CGSize(width: width, height: height)
  }
  
  @objc public class var width: CGFloat {
    return UIScreen.main.bounds.size.width
  }
  
  @objc public class var height: CGFloat {
    return UIScreen.main.bounds.size.height
  }
  
  public class func rateHeight(_ height: CGFloat) -> CGFloat {
    return round(height * (UIScreen.width / 375.0))
  }
  
  
  
}

// MARK: - StatusBar
extension UIScreen {
  
  public class var statusBarHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.height
  }
  
  public class var heightWithoutStatusBar: CGFloat {
    return currentOrientation.isPortrait ? height - statusBarHeight :
      UIScreen.main.bounds.size.width - statusBarHeight
  }
  
}

// MARK: - Orientation
extension UIScreen {
  
  @objc public class var currentOrientation: UIInterfaceOrientation {
    return UIApplication.shared.statusBarOrientation
  }
  
}

