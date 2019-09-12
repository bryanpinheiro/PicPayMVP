//
//  ManagerImage.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

class NetworkImage {
    
    static let shared = NetworkImage()
    
    var imageURLString: String?
    let imageCache = NSCache<NSString, AnyObject>()
    
    func downloadImageFrom(endpoint: String, completed: @escaping(UIImage) -> Void) {
        let url = URL(string: "\(endpoint)")!
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            completed(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    if let image = imageToCache {
                        
                        completed(image)
                    }
                }
                }.resume()
        }
    }
}
