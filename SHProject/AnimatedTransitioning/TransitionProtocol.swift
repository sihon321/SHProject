//
//  TransitionProtocol.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

protocol TransitionProtocol {
  func transitionCollectionView() -> UICollectionView!
}

protocol TransitionGridViewProtocol {
  func snapShotForTransition() -> UIView!
}
