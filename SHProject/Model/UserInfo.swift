//
//  UserInfo.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
  let meta: Meta
  let response: Response
}

struct Meta: Codable {
  let status: Int
  let msg: String
}

struct Response: Codable {
  let user: User
}

struct User: Codable {
  let name: String
  let likes, following: Int
  let defaultPostFormat: String
  let blogs: [Blog]
  
  enum CodingKeys: String, CodingKey {
    case name, likes, following
    case defaultPostFormat = "default_post_format"
    case blogs
  }
}

struct Blog: Codable {
  let admin, ask, askAnon: Bool
  let askPageTitle: String
  let canSendFanMail, canSubscribe: Bool
  let description: String
  let drafts: Int
  let facebook, facebookOpengraphEnabled: String
  let followed: Bool
  let followers: Int
  let isBlockedFromPrimary, isNsfw: Bool
  let likes, messages: Int
  let name: String
  let posts: Int
  let primary: Bool
  let queue: Int
  let shareLikes, subscribed: Bool
  let title: String
  let totalPosts: Int
  let tweet: String
  let twitterEnabled, twitterSend: Bool
  let type: String
  let updated: Int
  let url: String
  let uuid: String
  
  enum CodingKeys: String, CodingKey {
    case admin, ask
    case askAnon = "ask_anon"
    case askPageTitle = "ask_page_title"
    case canSendFanMail = "can_send_fan_mail"
    case canSubscribe = "can_subscribe"
    case description, drafts, facebook
    case facebookOpengraphEnabled = "facebook_opengraph_enabled"
    case followed, followers
    case isBlockedFromPrimary = "is_blocked_from_primary"
    case isNsfw = "is_nsfw"
    case likes, messages, name, posts, primary, queue
    case shareLikes = "share_likes"
    case subscribed, title
    case totalPosts = "total_posts"
    case tweet
    case twitterEnabled = "twitter_enabled"
    case twitterSend = "twitter_send"
    case type, updated, url, uuid
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

fileprivate func newJSONDecoder() -> JSONDecoder {
  let decoder = JSONDecoder()
  if #available(iOS 10.0, watchOS 3.0, *) {
    decoder.dateDecodingStrategy = .iso8601
  }
  return decoder
}
