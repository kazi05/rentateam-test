//
//  PhotoListViewController.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var presenter: PhotoListPresenter?
  
  convenience init(presenter: PhotoListPresenter) {
    self.init()
    self.presenter = presenter
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  private func delegating() {
    collectionView.delegate = self
  }
  
}

extension PhotoListViewController: UICollectionViewDelegate {
  
}
