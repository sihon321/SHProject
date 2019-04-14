//
//  Response.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation

protocol TumblrModelProtocol: Codable {
  var meta: Meta { set get }
  var response: Response { set get }
}

struct Meta: Codable {
  let status: Int?
  let msg: String?
}

struct Response: Codable {
  let user: User?
  let posts: [PostElement]?
}
