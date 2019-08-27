//
//  PhotoListPresenter.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class PhotoListPresenter: NSObject {
  
  private var photoListService: PhotoListService?
  private weak var photoListView: PhotoListView?
  
  private var photos = [Photo]()
  
  init(photoListService: PhotoListService) {
    self.photoListService = photoListService
  }
  
  func set(photoListView: PhotoListView) {
    self.photoListView = photoListView
  }
  
  func register(for collectionView: UICollectionView) {
    collectionView.register(PhotoCollectionViewCell.nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.name)
    collectionView.register(FooterView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.name)
  }
  
  func fetchPhotos(with page: Int = 1) {
    if page == 1 {
      photos = []
    }
    photoListService?.fetchPhotos(with: page, completion: { [weak self] (photos, error) in
      if let photos = photos {
        self?.photos += photos
        self?.photoListView?.displayPhotos()
      }
    })
  }
  
}

extension PhotoListPresenter: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.name, for: indexPath) as! PhotoCollectionViewCell
    let photo = photos[indexPath.row]
    cell.set(photo: photo)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    if kind == UICollectionView.elementKindSectionFooter {
      let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterView.name, for: indexPath)
      return footer
    } else {
      return UICollectionReusableView()
    }
  }
  
}
