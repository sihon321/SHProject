//
//  URLPath.swift
//  SHProject
//
//  Created by sihon321 on 13/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation

protocol Tumblr {
  var baseUrl: String { get }
  var blogUrl: String { get }
  var path: String { get }
}

extension Tumblr {
  var baseUrl: String { return "https://api.tumblr.com/v2" }
  var blogUrl: String { return baseUrl + "/blog"}
}

enum TumblrUrl {
  
  case userInfo
  case dashboard
  case avatar(by: String, with: Int)
}

extension TumblrUrl: Tumblr {
  var path: String {
    switch self {
    case .userInfo:
      return baseUrl + "/user/info"
    case .dashboard:
      return baseUrl + "/user/dashboard"
    case .avatar(let id, let size):
      return blogUrl + "/\(id).tumblr.com/avatar/\(size)"
    }
  }
}
