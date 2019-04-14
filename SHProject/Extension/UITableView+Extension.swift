//
//  UITableView+Extension.swift
//  SHProject
//
//  Created by sihon321 on 14/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

extension UITableViewCell: NibLoadableView { }

extension UITableViewCell: ReusableView { }

extension UITableView {
  
  func register<T: UITableViewCell>(_: T.Type) {
    
    let nib = UINib(nibName: T.nibName, bundle: nil)
    register(nib, forCellReuseIdentifier: T.reuseIdentifier)
  }
}
