//
//  PhotoDetailViewController.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 27/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
  
  //MARK: - Outlets
  
  @IBOutlet weak var imageScrollView: ImageScrollView!
  @IBOutlet weak var downloadedDateLabel: UILabel!
  
  //MARK: - Private properties
  
  private var presenter: PhotoDetailPresenter?
  
  convenience init(with presenter: PhotoDetailPresenter) {
    self.init()
    self.presenter = presenter
  }
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter?.set(photoDetailView: self)
    presenter?.displayPhotoDetail()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNeedsStatusBarAppearanceUpdate()
  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
  
  //MARK: - Actions
  
  @IBAction func actionClose(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}

//MARK: - View methods

extension PhotoDetailViewController: PhotoDetailView {
  
  func displayPhotoDetail(with photoDetail: PhotoDetail) {
    downloadedDateLabel.text = convertDateToString(date: photoDetail.downloadedDate)
    imageScrollView.display(photoDetail.image)
  }
  
  private func convertDateToString(date: Date) -> String {
    let dateformatter = DateFormatter()
    dateformatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
    dateformatter.locale = Locale.current
    dateformatter.dateFormat = "dd MMM, HH:mm"
    return dateformatter.string(from: date)
  }
  
}
