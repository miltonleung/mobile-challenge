//
//  Photo.swift
//  500pxChallenge
//
//  Created by Milton Leung on 2017-01-22.
//  Copyright © 2017 Milton Leung. All rights reserved.
//

import Foundation

public struct Photo {
  public let id: Int!
  public let name: String!
  public let votes: Int!
  public var thumbnailURL: String!
  public var imageURL: String!
}

extension Photo {
  init(dictionary: [String: Any]) {
    self.id = dictionary["id"] as! Int
    self.name = dictionary["name"] as! String
    self.votes = dictionary["votes_count"] as! Int
    
    self.imageURL = ""
    self.thumbnailURL = ""
    
    if let images = dictionary["images"] as? [[String: Any]] {
      for image in images {
        if image["size"] as! Int == 2 {
          self.thumbnailURL = image["https_url"] as! String
        } else if image["size"] as! Int == 4 {
          self.imageURL = image["https_url"] as? String
        }
      }
    }
  }
  
  mutating func update(dictionary: [String: Any]) {
    if let images = dictionary["images"] as? [String: Any] {
      if images["size"] as! Int == 4 {
        self.imageURL = images["https_url"] as? String
      }
    }
  }
}
