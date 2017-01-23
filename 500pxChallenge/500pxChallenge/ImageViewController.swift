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
  
  @IBOutlet fileprivate var photo: UIImageView!
  @IBOutlet fileprivate var nameLabel: UILabel!
  @IBOutlet fileprivate var voteCount: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameLabel.text = image.name
    voteCount.text = "\(image.votes!) votes"
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
        } catch let error {
          print(error)
        }
      }
    })
  }
}
