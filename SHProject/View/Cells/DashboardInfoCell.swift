//
//  DashboardInfoCell.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class DashboardInfoCell: UICollectionViewCell {
  
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
    
    let url = URL(string: post.photos?.first?.originalSize?.url ?? "")
    mainImageView.render(img: url)
    titleLabel.text = post.tags?.joined(separator: ",")
  }
  
  func snapShot() -> UIView! {
    let view = UIImageView(frame: mainImageView.bounds)
    view.image = mainImageView.image
    return view
  }
}

extension DashboardInfoCell {
  static func cellSize() -> CGSize {
    return CGSize(width: (UIScreen.width / 2) - 20.0, height: 300.0)
  }
}
