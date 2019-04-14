//
//  Response.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation

protocol TumblrModelProtocol: Codable {
  var meta: Meta? { set get }
  var response: TumblrResponse? { set get }
}

struct Meta: Codable {
  let status: Int?
  let msg: String?
}

struct TumblrResponse: Codable {
  let user: User?
  let posts: [PostElement]?
}

extension TumblrResponse {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(TumblrResponse.self, from: data)
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
  if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
    decoder.dateDecodingStrategy = .iso8601
  }
  return decoder
}
