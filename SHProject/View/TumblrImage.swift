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
  func setImage(_ imageView: UIImageView, _ urlStr: String, _ cornerRadius: CGFloat)
}

extension TumblrImage {
  func setImage(_ imageView: UIImageView, _ urlStr: String, _ cornerRadius: CGFloat = 0) {
    let url = URL(string: urlStr)
    let processor = DownsamplingImageProcessor(size: imageView.frame.size)
      >> RoundCornerImageProcessor(cornerRadius: cornerRadius)
    imageView.kf.indicatorType = .activity
    imageView.kf.setImage(
      with: url,
      placeholder: UIImage(named: "placeholderImage"),
      options: [
        .processor(processor),
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(1)),
        .cacheOriginalImage
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
