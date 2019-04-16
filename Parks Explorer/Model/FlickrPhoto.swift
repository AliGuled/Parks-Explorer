//
//  FlickrPhoto.swift
//  Parks Explorer
//
//  Created by Guled Ali on 4/9/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation
import UIKit

struct FlickrResponse: Decodable {
    let photos: FlickrPhotoResponse
}

struct FlickrPhotoResponse: Decodable {
    let photo: [FlickrPhotoData]
}

struct FlickrPhotoData: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
   // let url: String
}

