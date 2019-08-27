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
  
  init(datetime: Int, link: String) {
    self.datetime = datetime
    self.link = link
    
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    let datetime = aDecoder.decodeInteger(forKey: "datetime")
    let link = aDecoder.decodeObject(forKey: "link") as! String
    self.init(datetime: datetime, link: link)
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(datetime, forKey: "datetime")
    aCoder.encode(link, forKey: "link")
  }
}
