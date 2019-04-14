//
//  ListFooterView.swift
//  SHProject
//
//  Created by sihon321 on 14/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class ListFooterView: UICollectionReusableView {
  
  @IBOutlet weak var indicatorView: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    indicatorView.startAnimating()
  }
  
  override func prepareForReuse() {
    indicatorView.startAnimating()
  }
}

extension ListFooterView {
  static func size() -> CGSize {
    return CGSize(width: UIScreen.width, height: 100.0)
  }
}
