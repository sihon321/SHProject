//
//  DetailCollectionViewCell.swift
//  SHProject
//
//  Created by sihon321 on 10/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  
  var post: PostElement? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func config(_ post: PostElement?) {
    self.post = post
    let url = URL(string: post?.photos?.first?.originalSize?.url ?? "")
    imageView.render(img: url, contentMode: .scaleAspectFit)
  }
  
  func snapShotForTransition() -> UIView! {
    let snapShotView = UIImageView(frame: CGRect(origin: .zero,
                                                 size: CGSize(width: (UIScreen.main.bounds.size.width / 2) - 5.0,
                                                              height: 500.0)))
    snapShotView.backgroundColor = imageView.backgroundColor
    return snapShotView
  }
}

