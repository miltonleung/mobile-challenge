//
//  ViewController.swift
//  500pxChallenge
//
//  Created by Milton Leung on 2017-01-22.
//  Copyright © 2017 Milton Leung. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet fileprivate var collectionView: UICollectionView!
  
}

// MARK: Life Cycle
extension ViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.automaticallyAdjustsScrollViewInsets = false
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 12
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoThumbnailCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoThumbnailCollectionViewCell else { fatalError() }
    cell.image = #imageLiteral(resourceName: "SampleImage.png")
    return cell
  }
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    // Thumbnails should be 1/3 of the screen wide
    return CGSize(width: self.view.frame.width / 3 - 1, height: 120)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}

