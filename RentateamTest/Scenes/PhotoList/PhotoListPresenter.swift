//
//  PhotoListPresenter.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class PhotoListPresenter: NSObject {
  
  private weak var photoListService: PhotoListService?
  private weak var photoListView: PhotoListView?
  
  init(photoListService: PhotoListService) {
    self.photoListService = photoListService
  }
  
  func set(photoListView: PhotoListView) {
    self.photoListView = photoListView
  }
  
}
