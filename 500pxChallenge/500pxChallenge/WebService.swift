//
//  WebService.swift
//  500pxChallenge
//
//  Created by Milton Leung on 2017-01-22.
//  Copyright © 2017 Milton Leung. All rights reserved.
//

import Foundation

public final class WebService {
  public static let baseURL: String = "https://api.500px.com/v1/"
  
  public static let auth: String = "consumer_key=HdHraMY3LGHDRo47iRbBhVqniqCsFhnYzBsW6VSQ"
  
  public enum Endpoints {
    case PopularPhotos
    case PhotoByID(id: Int)
    
    public var method: String {
      switch self {
      case .PopularPhotos, .PhotoByID:
        return "GET"
      }
    }
    
    public var path: String {
      switch self {
      case .PopularPhotos:
        return baseURL + "photos?feature=popular&" + auth
      case .PhotoByID(let id):
        return baseURL + "photos/?\(id)" + auth
      }
    }
  }
  
  public static func request(endpoint: Endpoints, completion: @escaping ([String: Any]?) -> Void) {
    let session = URLSession(configuration: .default)
    var request = URLRequest(url: URL(string: endpoint.path)!)
    request.httpMethod = endpoint.method
    
    session.dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        print(error!)
        return
      }
      
      guard let responseData = data else {
        print("No data received")
        return
      }
      
      do {
        guard let dictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else { return }
        completion(dictionary)
      } catch (let error) {
        print(error)
        return
      }
    }.resume()
  }
}
