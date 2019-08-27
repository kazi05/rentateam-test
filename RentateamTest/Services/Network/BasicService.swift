//
//  BasicService.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BasicService {
  
  fileprivate struct APIConstants {
    static let host = "https://api.imgur.com"
    static let version = 3
    
    static let header = ["Authorization": "Client-ID 2d325dbb8dbf60c"]
  }
  
  
  func request(path: APIPath, with page: Int, and params: Parameters, completion: @escaping (_ json: JSON?, _ error: String?) -> Void) {
    let fullUrlString = String(format: "%@/%D/%@/%D", APIConstants.host, APIConstants.version, path.rawValue, page)
    
    if !Reachabelity.isConnectedToNetwork(){
      completion(nil, "No internet connection")
    } else {
      Alamofire
        .request(fullUrlString, method: path.method, parameters: params, encoding: URLEncoding.default, headers: APIConstants.header)
        .responseJSON { (response) in
          switch response.result {
          case .failure(let error): completion(nil, error.localizedDescription)
          case .success(let value):
            let json = JSON(value)
            completion(json, nil)
          }
      }
    }
  }
}

enum APIPath: String {
  case fetchPhotos = "gallery/r/pics/top/"
  
  var method: HTTPMethod {
    switch self {
    case .fetchPhotos: return .get
    default: return .post
    }
  }
}
