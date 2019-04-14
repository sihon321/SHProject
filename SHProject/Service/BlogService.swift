//
//  BlogService.swift
//  SHProject
//
//  Created by sihon321 on 13/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class BlogService {
  
  static let shared = BlogService()
  
  func requestAvatar(_ id: String, size: Int, _ completion: @escaping (Image?) -> Void) {
    guard let url = URL(string: TumblrUrl.avatar(by: id, with: size).path) else {
      return
    }
    Alamofire.request(url, method: .get)
      .responseImage { response in
        switch response.result {
        case .success(let image):
          completion(image)
        case .failure(let error):
          completion(nil)
          debugPrint(error)
        }
    }
  }
}
