//
//  PhotoListServiceImplementation.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation

class PhotoListServiceImplementation: BasicService, PhotoListService {
  
  func fetchPhotos(with page: Int, completion: @escaping ([Photo]?, String?) -> Void) {
    
    request(path: APIPath.fetchPhotos, with: page, and: [:]) { (json, error) in
      if let error = error {
        completion(nil, error)
      }
      
      if let json = json {
        var photos = [Photo]()
        guard let results = json["data"].array else {
          completion(nil, nil)
          return
        }
        
        for item in results {
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try item.rawData()
            let photo = try jsonDecoder.decode(Photo.self, from: data)
            photos.append(photo)
          } catch {
            print(error.localizedDescription)
            completion(nil, error.localizedDescription)
          }
        }
        
        completion(photos, nil)
      }
    }
  }
  
}
