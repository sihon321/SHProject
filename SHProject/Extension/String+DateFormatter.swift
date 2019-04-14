//
//  String+DateFormat.swift
//  SHProject
//
//  Created by sihon321 on 14/04/2019.
//  Copyright © 2019 sihon. All rights reserved.
//

import Foundation

extension String {
  
  func convertDateString() -> String? {
    return convert(dateString: self, fromDateFormat: "yyyy-MM-dd HH:mm:ss ZZZ", toDateFormat: "yyyy-MM-dd")
  }
  
  func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> String? {
    
    let fromDateFormatter = DateFormatter()
    fromDateFormatter.dateFormat = fromDateFormat
    
    if let fromDateObject = fromDateFormatter.date(from: dateString) {
      
      let toDateFormatter = DateFormatter()
      toDateFormatter.dateFormat = toDateFormat
      
      let newDateString = toDateFormatter.string(from: fromDateObject)
      return newDateString
    }
    
    return nil
  }
  
}
