//
//  NibLoadableView.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
  static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
  
  static var nibName: String {
    guard let name = String(describing: self).components(separatedBy: ".").last else {
      return ""
    }
    
    return name
  }
}

protocol ReusableView: class {
  static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
