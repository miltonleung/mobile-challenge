//
//  ImagePageViewController.swift
//  500pxChallenge
//
//  Created by Milton Leung on 2017-01-22.
//  Copyright © 2017 Milton Leung. All rights reserved.
//

import UIKit

class ImagePageViewController: UIPageViewController {
  fileprivate var imageViewControllers = [ImageViewController]()
  var popularPhotos: [Photo]!
  var startingIndex: Int!
}
extension ImagePageViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    for photo in popularPhotos {
      let imageVC = storyboard.instantiateViewController(withIdentifier: ImageViewController.identifier) as! ImageViewController
      imageVC.image = photo
      imageViewControllers.append(imageVC)
    }
    self.setViewControllers([self.imageViewControllers[startingIndex]], direction: .forward, animated: true, completion: nil)
  }
}

extension ImagePageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard imageViewControllers.count > 1 else  { return nil }
    guard let vcIndex = imageViewControllers.index(of: viewController as! ImageViewController) else { return nil }
    
    let nextIndex = vcIndex + 1
    
    if nextIndex == imageViewControllers.count {
      return imageViewControllers.first
    } else if nextIndex > imageViewControllers.count {
      return nil
    } else {
      return imageViewControllers[nextIndex]
    }
  }
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard imageViewControllers.count > 1 else  { return nil }
    guard let vcIndex = imageViewControllers.index(of: viewController as! ImageViewController) else { return nil }
    
    let nextIndex = vcIndex - 1
    
    if nextIndex < 0 {
      return imageViewControllers.last
    } else if nextIndex > imageViewControllers.count {
      return nil
    } else {
      return imageViewControllers[nextIndex]
    }
  }
}
