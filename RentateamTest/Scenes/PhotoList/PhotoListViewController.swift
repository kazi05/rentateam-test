//
//  PhotoListViewController.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController {
  
  //MARK: - Outlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  //MARK: - Private properties
  
  private var presenter: PhotoListPresenter?
  private var page = 1
  
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
  
  convenience init(presenter: PhotoListPresenter) {
    self.init()
    self.presenter = presenter
  }
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter?.set(photoListView: self)
    presenter?.fetchPhotos()
    configureCollectionView()
    refreshControl.beginRefreshing()
    
  }
  
  //MARK: - Decoration
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = presenter
    presenter?.register(for: collectionView)
    collectionView.collectionViewLayout = layout
    collectionView.refreshControl = refreshControl
  }
  
  //MARK: - Actions
  
  @objc private func refreshPhotos() {
    presenter?.fetchPhotos()
  }
  
}

//MARK: - UICollectionViewDelegate

extension PhotoListViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    if elementKind == UICollectionView.elementKindSectionFooter {
      presenter?.fetchPhotos(with: page)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let photoDetail = presenter?.photoDetail(for: indexPath.row) else { return }
    
    //При больщом проекте использовать отдельный слой Coordinator/Router
    let photoDetailPresenter = PhotoDetailPresenter(with: photoDetail)
    let photoDetailViewController = PhotoDetailViewController(with: photoDetailPresenter)
    present(photoDetailViewController, animated: true, completion: nil)
  }
  
}

//MARK: - PhotoListView Methods

extension PhotoListViewController: PhotoListView {
  
  func displayPhotos() {
    page += 1
    DispatchQueue.main.async {
      self.collectionView.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  
  func displayError(with title: String, and message: String) {
    showAlert(title: title, message: message) {
      self.refreshControl.endRefreshing()
    }
  }
}
