//
//  UIView+Origin.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

extension UIView{
  
  func origin (_ point : CGPoint){
    frame.origin.x = point.x
    frame.origin.y = point.y
  }
}
