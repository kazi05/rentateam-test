//
//  PhotoListService.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation

protocol PhotoListService {
  func fetchPhotos(with page: Int, completion: @escaping ([Photo]?, Error?) -> Void)
}
