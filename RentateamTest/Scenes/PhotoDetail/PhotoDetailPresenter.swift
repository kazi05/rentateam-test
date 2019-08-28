//
//  PhotoDetailPresenter.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 28/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation

class PhotoDetailPresenter {
  
  //MARK: - Private properties
  
  private weak var photoDetailView: PhotoDetailView?
  private var photoDetail: PhotoDetail?
  
  //MARK: - Configure
  
  init(with photo: PhotoDetail) {
    self.photoDetail = photo
  }
  
  func set(photoDetailView: PhotoDetailView) {
    self.photoDetailView = photoDetailView
  }
  
  //MARK: - View methods
  
  func displayPhotoDetail() {
    guard let photo = photoDetail else { return }
    photoDetailView?.displayPhotoDetail(with: photo)
  }
  
}
