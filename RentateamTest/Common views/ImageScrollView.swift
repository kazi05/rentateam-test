//
//  ImageScrollView.swift
//  RentateamTest
//
//  Created by Kazim Gajiev on 28/08/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {
  
  //MARK: - Private properties
  
  private var zoomView: UIImageView!
  
  private lazy var zoomingTap: UITapGestureRecognizer = {
    let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap(_:)))
    zoomingTap.numberOfTapsRequired = 2
    
    return zoomingTap
  }()
  
  //MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
    decelerationRate = UIScrollView.DecelerationRate.fast
    delegate = self
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    centerImage()
  }
  
  
  //MARK: - Configure scrollView to display new image
  
  func display(_ image: UIImage) {
    zoomView?.removeFromSuperview()
    zoomView = nil
    
    zoomView = UIImageView(image: image)
    
    addSubview(zoomView)
    
    configureFor(image.size)
  }
  
  private func configureFor(_ imageSize: CGSize) {
    contentSize = imageSize
    setMaxMinZoomScaleForCurrentBounds()
    zoomScale = minimumZoomScale
    
    zoomView.addGestureRecognizer(zoomingTap)
    zoomView.isUserInteractionEnabled = true
  }
  
  //MARK: - Calculating
  
  private func setMaxMinZoomScaleForCurrentBounds() {
    let boundsSize = bounds.size
    let imageSize = zoomView.bounds.size
    
    let xScale =  boundsSize.width  / imageSize.width
    let yScale = boundsSize.height / imageSize.height
    
    let minScale = min(xScale, yScale)
    
    var maxScale: CGFloat = 1.0
    
    if minScale < 0.1 {
      maxScale = 0.3
    }
    
    if minScale >= 0.1 && minScale < 0.5 {
      maxScale = 0.7
    }
    
    if minScale >= 0.5 {
      maxScale = max(1.0, minScale)
    }
    
    maximumZoomScale = maxScale
    minimumZoomScale = minScale
  }
  
  private func centerImage() {
    let boundsSize = self.bounds.size
    var frameToCenter = zoomView?.frame ?? CGRect.zero
    
    if frameToCenter.size.width < boundsSize.width {
      frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width)/2
    }
    else {
      frameToCenter.origin.x = 0
    }
    
    if frameToCenter.size.height < boundsSize.height {
      frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height)/2
    }
    else {
      frameToCenter.origin.y = 0
    }
    
    zoomView?.frame = frameToCenter
  }
  
  
  //MARK: - UIScrollView Delegate Methods
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.zoomView
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    self.centerImage()
  }
  
  //MARK: - Handle ZoomTap
  
  @objc private func handleZoomingTap(_ sender: UITapGestureRecognizer) {
    let location = sender.location(in: sender.view)
    self.zoom(to: location, animated: true)
    
  }
  
  private func zoom(to point: CGPoint, animated: Bool) {
    let currentScale = self.zoomScale
    let minScale = self.minimumZoomScale
    let maxScale = self.maximumZoomScale
    
    if (minScale == maxScale && minScale > 1) {
      return;
    }
    
    let toScale = maxScale
    let finalScale = (currentScale == minScale) ? toScale : minScale
    let zoomRect = self.zoomRect(for: finalScale, withCenter: point)
    self.zoom(to: zoomRect, animated: animated)
  }
  
  private func zoomRect(for scale: CGFloat, withCenter center: CGPoint) -> CGRect {
    var zoomRect = CGRect.zero
    let bounds = self.bounds
    
    zoomRect.size.width = bounds.size.width / scale
    zoomRect.size.height = bounds.size.height / scale
    
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
    
    return zoomRect
  }
  
  
}
