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
  
  fileprivate var popularPhotos = [Photo]() {
    didSet {
      collectionView.reloadData()
    }
  }
  
  fileprivate var selectedPhoto: Photo?
}

// MARK: Life Cycle
extension ViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.automaticallyAdjustsScrollViewInsets = false
    getPopularPhotos()
  }
  
  func getPopularPhotos() {
    WebService.request(endpoint: .PopularPhotos, completion: { dictionary in
      guard dictionary != nil else { return }
      guard let photos = dictionary!["photos"] as? [[String: Any]] else { return }
      var photosList = [Photo]()
      for photo in photos {
        photosList.append(Photo(dictionary: photo))
      }
      self.popularPhotos = photosList
    })
  }
}

// MARK - Segues
extension ViewController {
  enum segues: String {
    case 
  }
}

//MARK - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return popularPhotos.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoThumbnailCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoThumbnailCollectionViewCell else { fatalError() }
    cell.image = popularPhotos[indexPath.item]
    return cell
  }
}
//MARK - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    // Thumbnails should be 1/3 of the screen wide
    return CGSize(width: self.view.frame.width / 4 - 3, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedPhoto = popularPhotos[indexPath.item[]
  }
}

