//
//  Int+NumberFormatter.swift
//  SHProject
//
//  Created by sihon321 on 14/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation

extension Int {
  private static var commaFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
  
  internal var commaRepresentation: String {
    return Int.commaFormatter.string(from: NSNumber(value: self))!
  }
}
