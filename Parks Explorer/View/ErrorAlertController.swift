//
//  ErrorAlertController.swift
//  Parks Explorer
//
//  Created by Guled Ali on 4/9/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit

class ErrorAlertController {
    
    static func alert(title: String = "Error", message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        return alert
        
    }
}


