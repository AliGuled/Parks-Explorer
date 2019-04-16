//
//  FlickrService.swift
//  Parks Explorer
//
//  Created by Guled Ali on 4/9/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation
import UIKit

enum FlickrServiceError: Error {
    case RequestFailded
    case CouldNotParseResponse
    case ImageDownloadFailed
}

class FlickrService {
    
    let apikey = "4eec853b35cc8ea2f41dedf8cbc05839"
    
    func searchPhotos(query: String, completion: @escaping ([FlickrPhotoData]?, Error?) -> Void) {
        
        let url = buildSearchURL(query: query)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {(data, response, error) in
            
            if let results = data {
                do {
                    let decoder = JSONDecoder()
                    
                    let results = try decoder.decode(FlickrResponse.self, from: results)
                    completion(results.photos.photo, nil)
                } catch {
                    print(error)
                    completion(nil, FlickrServiceError.CouldNotParseResponse)
                }
            }
            
            else {
                print(error!)
                completion(nil, FlickrServiceError.RequestFailded)
            }
        }
        
        task.resume()
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let url = URL(string: url)
        
        let task  = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                
                let image = UIImage(data: data)
                completion(image, nil)
            } else {
                print(error!)
                completion(nil, FlickrServiceError.ImageDownloadFailed)
            }
        }
        
        task.resume()
        
        
    }
    
    func buildSearchURL(query: String) -> URL? {
        
        let components: URLComponents = {
            
            var compoents = URLComponents()
            compoents.scheme = "https"
            compoents.host = "api.flickr.com"
            compoents.path = "/services/rest"
            
            compoents.queryItems = [
                
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: apikey),
                URLQueryItem(name: "tags", value: query),
                URLQueryItem(name: "sort", value: "relevance"),
                URLQueryItem(name: "per_page", value: "40"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
               

            ]
            
            return compoents
            
        }()
        
        let url = components.url
        return url
    }
    
    
}
