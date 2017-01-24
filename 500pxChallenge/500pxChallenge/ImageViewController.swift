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
  
  var darkMode: Bool = false {
    didSet {
      if darkMode {
        self.view.backgroundColor = UIColor.black
        nameLabel.textColor = UIColor.white
        voteCount.textColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: true)
      } else {
        self.view.backgroundColor = UIColor.white
        nameLabel.textColor = UIColor.black
        voteCount.textColor = UIColor.black
        navigationController?.setNavigationBarHidden(false, animated: true)
      }
    }
  }
  
  @IBOutlet fileprivate var photo: UIImageView! {
    didSet {
      photo.isUserInteractionEnabled = true
    }
  }
  @IBOutlet fileprivate var nameLabel: UILabel!
  @IBOutlet fileprivate var voteCount: UILabel!
}

// MARK: Life Cycle
extension ImageViewController {
  override func viewWillAppear(_ animated: Bool) {
    darkMode = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(false, animated: true)
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

// MARK - IBAction
extension ImageViewController {
  @IBAction func imageViewTapped() {
    darkMode = !darkMode
  }
}
