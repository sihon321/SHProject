//
//  ListCollectionViewCell.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func snapShot() -> UIView! {
    let view = UIImageView(frame: imageView.bounds)
    view.backgroundColor = imageView.backgroundColor
    return view
  }
}
