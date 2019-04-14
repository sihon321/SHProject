//
//  File.swift
//  SHProject
//
//  Created by sihon321 on 12/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation

struct DashboardInfo: TumblrModelProtocol {
  var meta: Meta
  var response: Response
}

struct PostElement: Codable {
  let type: PostType?
  let blogName: String?
  let blog: PostBlog?
  let id: Int?
  let postURL: String?
  let date: String?
  let tags: [String]?
  let shortURL: String?
  let summary: String?
  let followed, liked: Bool?
  let noteCount: Int?
  let trail: [Trail]?
  let imagePermalink: String?
  let photos: [Photo]?
  
  enum CodingKeys: String, CodingKey {
    case type
    case blogName = "blog_name"
    case blog
    case id
    case postURL = "post_url"
    case date
    case tags
    case shortURL = "short_url"
    case summary
    case followed, liked
    case noteCount = "note_count"
    case trail
    case imagePermalink = "image_permalink"
    case photos
  }
}

enum PostType: String, Codable {
  case photo, text, answer, video
}

struct PostBlog: Codable {
  let name, title, description: String?
  let url: String?
  let uuid: String?
  let updated: Int?
}

struct Photo: Codable {
  let caption: String?
  let originalSize: Size?
  let altSizes: [Size]?
  
  enum CodingKeys: String, CodingKey {
    case caption
    case originalSize = "original_size"
    case altSizes = "alt_sizes"
  }
}

struct Size: Codable {
  let url: String?
  let width, height: Int?
}

struct Trail: Codable {
  let blog: TrailBlog?
  let content: String?
  
  enum CodingKeys: String, CodingKey {
    case blog
    case content
  }
}

struct TrailBlog: Codable {
  let name: String?
  let active: Bool?
  let theme: Theme?
  
  enum CodingKeys: String, CodingKey {
    case name, active, theme
  }
}

struct Theme: Codable {
  let avatarShape, backgroundColor, bodyFont: String?
  let headerImage, headerImageFocused, headerImageScaled: String?
  let headerStretch: Bool?
  let linkColor: String?
  let titleColor, titleFont, titleFontWeight: String?
  
  enum CodingKeys: String, CodingKey {
    case avatarShape = "avatar_shape"
    case backgroundColor = "background_color"
    case bodyFont = "body_font"
    case headerImage = "header_image"
    case headerImageFocused = "header_image_focused"
    case headerImageScaled = "header_image_scaled"
    case headerStretch = "header_stretch"
    case linkColor = "link_color"
    case titleColor = "title_color"
    case titleFont = "title_font"
    case titleFontWeight = "title_font_weight"
  }
}

// MARK: Convenience initializers and mutators

extension DashboardInfo {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(DashboardInfo.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
}

extension Response {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(Response.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
}

extension PostElement {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(PostElement.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
}

extension PostBlog {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(PostBlog.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
  
  init(fromURL url: URL) throws {
    try self.init(data: try Data(contentsOf: url))
  }

}

extension Photo {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(Photo.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }

}

extension Size {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(Size.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }

}

extension Trail {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(Trail.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }

}

extension Theme {
  init(data: Data) throws {
    self = try newJSONDecoder().decode(Theme.self, from: data)
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
