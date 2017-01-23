//
//  ImageViewController.swift
//  500pxChallenge
//
//  Created by Milton Leung on 2017-01-22.
//  Copyright © 2017 Milton Leung. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
  static let identifier = "\(ImageViewController.self)"
  
  var image: Photo!
  
  @IBOutlet fileprivate var photo: UIImageView! {
    didSet {
      photo.contentMode = .scaleAspectFit
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    WebService.request(endpoint: .PhotoByID(id: image.id), completion: { dictionary in
      guard dictionary != nil else { return }
      guard let photoInfo = dictionary!["photo"] as? [String: Any] else { return }
      self.image.update(dictionary: photoInfo)
      DispatchQueue.global().async {
        do {
          let data = try Data(contentsOf: URL(string: self.image.imageURL)!)
          DispatchQueue.main.async {
            self.photo.image = UIImage(data: data)
          }
        } catch let error as Error {
          print(error)
        }
      }
    })
  }
}
