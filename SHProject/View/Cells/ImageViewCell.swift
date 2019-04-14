//
//  ImageViewCell.swift
//  SHProject
//
//  Created by sihon321 on 13/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit

class ImageViewCell: UITableViewCell, TumblrImage {

  var urlStr: String = "" {
    didSet {
      setImage(mainImageView, urlStr)
    }
  }
  
  @IBOutlet weak var mainImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    guard let imageView = self.mainImageView else {
      return
    }
    imageView.frame = CGRect.zero
    
    if (imageView.image != nil) {
      imageView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.width,
                               height: ImageViewCell.height())
    }
  }
    
}

extension ImageViewCell {
  static func height() -> CGFloat {
    return 400.0
  }
}
