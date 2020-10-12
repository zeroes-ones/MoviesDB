//
//  String+Extension.swift
//  Movies
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}
