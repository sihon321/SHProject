//
//  DashboardInfoCell.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class DashboardInfoCell: UICollectionViewCell, TumblrImage {
  
  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func config(_ post: PostElement?) {
    guard let post = post else {
      return
    }
    
    let urlStr = post.photos?.first?.originalSize?.url ?? ""
    setImage(mainImageView, urlStr, 20)
    
    if post.tags?.isEmpty ?? true {
      titleLabel.text = post.summary
    } else {
      titleLabel.text = post.tags?
        .map({ "#"+$0 })
        .joined(separator: ", ")
    }
  }
  
  func snapShot() -> UIView! {
    let view = UIImageView(frame: mainImageView.bounds)
    view.image = mainImageView.image
    return view
  }
}

extension DashboardInfoCell {
  static func size() -> CGSize {
    return CGSize(width: (UIScreen.width / 2) - 20.0, height: 300.0)
  }
}
