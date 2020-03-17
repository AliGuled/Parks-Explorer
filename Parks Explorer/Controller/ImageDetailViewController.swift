//
//  ImageDetailViewController.swift
//  Parks Explorer
//
//  Created by Guled Ali on 4/9/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit
class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var photoDetail: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var flickrImage: FlickrImage?
    var flickrService = FlickrService()
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let photoData = flickrImage?.photoData
        photoDetail.text = photoData?.title
        let photo = flickrImage?.thumnail
        imageView.image = photo
        let url = flickrImage!.fullURL
    
        //textView.text = "\(photoData?.url)"
        
        flickrService.downloadImage(url: url!) { (image: UIImage?,error: Error?) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    self.present(ErrorAlertController.alert(message: "Error fetching photo"), animated: true)
                } else {
                    DispatchQueue.main.async {
                        self.imageView.image = image

                    }
                }
            }
        }
        
    }

}
