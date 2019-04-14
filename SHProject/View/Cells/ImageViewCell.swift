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
      setImage(mainImageView, urlStr, true, 0)
    }
  }
  
  @IBOutlet weak var mainImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
  }

}
