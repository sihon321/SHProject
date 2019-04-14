//
//  UserInfo.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation

struct UserInfo: TumblrModelProtocol {
  var meta: Meta?
  var response: TumblrResponse?
}

struct User: Codable {
  let name: String?
  let likes, following: Int?
  let blogs: [Blog]?
  
  enum CodingKeys: String, CodingKey {
    case name, likes, following
    case blogs
  }
}

struct Blog: Codable {
  let posts, followers: Int?
  let title: String?
  
  enum CodingKeys: String, CodingKey {
    case posts, followers
    case title
  }
}

// MARK: Convenience initializers and mutators

extension UserInfo {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(UserInfo.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
}

extension User {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(User.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
}

extension Blog {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(Blog.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
}

private func newJSONDecoder() -> JSONDecoder {
  let decoder = JSONDecoder()
  if #available(iOS 10.0, watchOS 3.0, *) {
    decoder.dateDecodingStrategy = .iso8601
  }
  return decoder
}
