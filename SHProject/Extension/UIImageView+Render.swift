//
//  UIImageView+Render.swift
//  SHProject
//
//  Created by sihon321 on 13/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  
  func render(img url: URL?, contentMode: UIView.ContentMode = .scaleAspectFill) {
    let imageUrl = url
    image = nil
    self.contentMode = contentMode
    
    self.kf.cancelDownloadTask()

    if let url = imageUrl {
      let cacheType = ImageCache.default.imageCachedType(forKey: url.absoluteString)
      switch cacheType {
      case .none:
        self.kf.setImage(with: ImageResource(downloadURL: url),
                         placeholder: UIImage(named: "placeholderImage"),
                         options: [
                          .scaleFactor(UIScreen.main.scale),
                          .transition(.fade(1)),
                          .cacheOriginalImage
          ]) { (img, _ , _ , _) in
          if let im = img {
            DispatchQueue.global(qos: .background).async {
              ImageCache.default.store(im, forKey: url.absoluteString)
            }
          }
          self.clipsToBounds = true
        }
        
      case .memory:
        self.image = ImageCache.default.retrieveImageInMemoryCache(forKey: url.absoluteString)
        
      case .disk:
        self.image = ImageCache.default.retrieveImageInDiskCache(forKey: url.absoluteString)
      }
      
      self.clipsToBounds = true
    } else {
      image = nil
    }
  }
}
