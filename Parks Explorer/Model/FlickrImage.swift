//
//  FlickrImage.swift
//  Parks Explorer
//
//  Created by Guled Ali on 4/9/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit

class FlickrImage  {
    var photoData: FlickrPhotoData?
    var thumnail: UIImage?
    var full: UIImage?
   // var link: String?
    
    init(phtoData: FlickrPhotoData) {
        self.photoData = phtoData
    }
    
    var thumbnailURL: String? {
        guard let photo = photoData else {return nil}
        return "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_q.jpg"
    }
    
    var fullURL: String? {
        guard let photo = photoData else {return nil}
        return "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_b.jpg"
    }
    
//    var urlString: String? {
//        guard let photo = photoData else {return nil}
//       return "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_b.jpg"
//    }
}
