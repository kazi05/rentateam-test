//
//  Photo.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation

struct Photo: Codable {
  let title: String
  let datetime: Int
  let link: String
  
  let downloaded: Date
  
  init(title: String, datetime: Int, link: String) {
    self.title = title
    self.datetime = datetime
    self.link = link
    self.downloaded = Date()
  }
}
