//
//  PhotoThumbnailCollectionViewCell.swift
//  500pxChallenge
//
//  Created by Milton Leung on 2017-01-22.
//  Copyright © 2017 Milton Leung. All rights reserved.
//

import UIKit

class PhotoThumbnailCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "\(PhotoThumbnailCollectionViewCell.self)"

  @IBOutlet fileprivate var photo: UIImageView! {
    didSet {
      self.photo.contentMode = .scaleAspectFit
    }
  }
  
  var image: UIImage! {
    didSet {
      photo.image = image
    }
  }
}
