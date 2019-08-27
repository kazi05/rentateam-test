//
//  Photo.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation

class Photo: NSObject, Codable, NSCoding {
  let datetime: Int
  let link: String
  let downloadedDate: Date
  
  init(datetime: Int, link: String, downloadedDate: Date) {
    self.datetime = datetime
    self.link = link
    self.downloadedDate = downloadedDate
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    let datetime = aDecoder.decodeInteger(forKey: "datetime")
    let link = aDecoder.decodeObject(forKey: "link") as! String
    let downloadedDate = aDecoder.decodeObject(forKey: "downloadedDate") as! Date
    self.init(datetime: datetime, link: link, downloadedDate: downloadedDate)
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(datetime, forKey: "datetime")
    aCoder.encode(link, forKey: "link")
    aCoder.encode(downloadedDate, forKey: "downloadedDate")
  }
  
  private enum CodingKeys: String, CodingKey {
    case datetime
    case link
    case downloadedDate
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    datetime = try container.decode(Int.self, forKey: .datetime)
    link = try container.decode(String.self, forKey: .link)
    downloadedDate = try container.decodeIfPresent(Date.self, forKey: .downloadedDate) ?? Date()
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(datetime, forKey: .datetime)
    try container.encode(link, forKey: .link)
    try container.encode(downloadedDate, forKey: .downloadedDate)
  }
}
