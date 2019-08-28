//
//  PhotoListPresenter.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoListPresenter: NSObject {
  
  //MARK: - Private properties
  
  private var photoListService: PhotoListService?
  private weak var photoListView: PhotoListView?
  private let userDefaults = UserDefaults.standard
  private var photos = [Photo]()
  
  //MARK: - Configure
  
  init(photoListService: PhotoListService) {
    self.photoListService = photoListService
  }
  
  func set(photoListView: PhotoListView) {
    self.photoListView = photoListView
  }
  
  //MARK: - View methods
  
  func register(for collectionView: UICollectionView) {
    collectionView.register(PhotoCollectionViewCell.nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.name)
    collectionView.register(FooterView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.name)
  }
  
  //MARK: - Service methods
  
  func fetchPhotos(with page: Int = 1) {
    if page == 1 {
      loadFromDisk()
    }
    photoListService?.fetchPhotos(with: page, completion: { [weak self] (photos, error) in
      
      if let error = error {
        self?.photoListView?.displayError(with: error, and: "")
      }
      
      if let photos = photos {
        if page == 1 {
          self?.photos = []
          var cachedPhotos = [Photo]()
          for i in 0...20 {
            cachedPhotos.append(photos[i])
          }
          self?.saveToDisk(photos: cachedPhotos)
        }
        self?.photos += photos
        self?.photoListView?.displayPhotos()
      }
    })
  }
  
  private func saveToDisk(photos: [Photo]) {
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: photos)
    userDefaults.set(encodedData, forKey: "cachedPhotos")
    userDefaults.synchronize()
  }
  
  private func loadFromDisk() {
    if let decoded  = userDefaults.data(forKey: "cachedPhotos"), let decodedPhotos = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [Photo] {
      photos += decodedPhotos
    }
  }
  
  //MARK: - For routing
  
  func photoDetail(for index: Int) -> PhotoDetail? {
    let photo = photos[index]
    guard let image = SDImageCache.shared.imageFromDiskCache(forKey: photo.link) else { return nil }
    
    return PhotoDetail(image: image, downloadedDate: photo.downloadedDate)
  }
  
}

//MARK: - UICollectionViewDataSource

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
