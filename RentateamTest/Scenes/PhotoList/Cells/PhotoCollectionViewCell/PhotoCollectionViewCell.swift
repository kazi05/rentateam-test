//
//  PhotoCollectionViewCell.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell, NibLoadable {
  
  @IBOutlet weak var photoImage: UIImageView!
  @IBOutlet weak var photoDate: UILabel!

  func set(photo: Photo) {
    guard let url = URL(string: photo.link) else { return }
    photoImage.sd_setImage(with: url, completed: nil)
    photoDate.text = convertTimeStampToDate(date: photo.datetime)
  }
  
  private func convertTimeStampToDate(date: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(date))
    let dateformatter = DateFormatter()
    dateformatter.locale = Locale.current
    dateformatter.dateFormat = "dd MMM"
    return dateformatter.string(from: date)
  }

}
