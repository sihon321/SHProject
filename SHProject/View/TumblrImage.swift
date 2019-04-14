//
//  TumblrImageProtocol.swift
//  SHProject
//
//  Created by sihon321 on 14/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit
import Kingfisher

protocol TumblrImage {
  func setImage(_ imageView: UIImageView,
                _ urlStr: String,
                _ isAnimation: Bool,
                _ cornerRadius: CGFloat)
}

extension TumblrImage {
  func setImage(_ imageView: UIImageView,
                _ urlStr: String,
                _ isAnimation: Bool,
                _ cornerRadius: CGFloat = 0.0) {
    let url = URL(string: urlStr)
    var processor: ImageProcessor?
    
    if isAnimation {
      processor = DefaultImageProcessor()
    } else {
      processor = DownsamplingImageProcessor(size: imageView.frame.size)
    }
    
    if cornerRadius != 0.0 {
      processor = processor! >> RoundCornerImageProcessor(cornerRadius: cornerRadius)
    }
    
    if let processor = processor {
      imageView.kf.indicatorType = .activity
      imageView.kf.setImage(
        with: url,
        placeholder: UIImage(named: "placeholderImage"),
        options: [
          .processor(processor),
          .scaleFactor(UIScreen.main.scale),
          .transition(.fade(1)),
        ])
      {
        result in
        switch result {
        case .success(let value):
          print("Task done for: \(value.source.url?.absoluteString ?? "")")
        case .failure(let error):
          print("Job failed: \(error.localizedDescription)")
        }
      }
    }
    
  }
  
}
