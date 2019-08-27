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
  private var page = 1
  
  convenience init(presenter: PhotoListPresenter) {
    self.init()
    self.presenter = presenter
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter?.set(photoListView: self)
    presenter?.fetchPhotos()
    configureCollectionView()
    refreshControl.beginRefreshing()
    
  }
  
  private let layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let padding: CGFloat = 2.0
    let width = UIScreen.main.bounds.width / 3 - (padding * 2)
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    layout.itemSize = CGSize(width: width, height: width)
    layout.minimumLineSpacing = padding
    layout.minimumInteritemSpacing = padding
    layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
    return layout
  }()
  
  let refreshControl: UIRefreshControl = {
    let control = UIRefreshControl()
    control.addTarget(self, action: #selector(refreshPhotos), for: .valueChanged)
    return control
  }()
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = presenter
    presenter?.register(for: collectionView)
    collectionView.collectionViewLayout = layout
    collectionView.refreshControl = refreshControl
  }
  
  @objc private func refreshPhotos() {
    presenter?.fetchPhotos()
  }
  
}

extension PhotoListViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    if elementKind == UICollectionView.elementKindSectionFooter {
      presenter?.fetchPhotos(with: page)
    }
  }
  
}

extension PhotoListViewController: PhotoListView {
  
  func displayPhotos() {
    collectionView.reloadData()
    refreshControl.endRefreshing()
    page += 1
  }
}
