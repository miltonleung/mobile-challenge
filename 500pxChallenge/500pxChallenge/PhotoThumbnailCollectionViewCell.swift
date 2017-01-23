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
  
  var image: Photo! {
    didSet {
      DispatchQueue.global().async {
        do {
          let data = try Data(contentsOf: URL(string: self.image.thumbnailURL)!)
          DispatchQueue.main.async {
            self.photo.image = UIImage(data: data)
          }
        } catch let error as Error {
          print(error)
        }
      }
    }
  }
}
