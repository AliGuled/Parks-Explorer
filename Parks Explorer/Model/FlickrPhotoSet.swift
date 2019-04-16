//
//  FlickrPhotoSet.swift
//  Parks Explorer
//
//  Created by Guled Ali on 4/9/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit

class FlickrPhotoSet {
    
    var photoData: [FlickrPhotoData]
    var images: [FlickrImage]
    
    let flickrService = FlickrService()
    
    init(photoData: [FlickrPhotoData]) {
        self.photoData = photoData
        self.images = self.photoData.map({FlickrImage(phtoData: $0)})
    }
    
    func downloadThumbnailFor(index: Int, completion: @escaping (UIImage?, Error?) -> Void) {
        let image = images[index]
        flickrService.downloadImage(url: image.thumbnailURL!) { (image: UIImage?, error: Error?) in
            
            self.images[index].thumnail = image
            completion(image, error)
        }
        
        
    }
    
    var count: Int {
        return images.count
    }
    
    func photoAt(index: Int) -> FlickrPhotoData? {
        return photoData[index]
    }
}
