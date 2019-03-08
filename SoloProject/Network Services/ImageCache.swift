//
//  ImageCache.swift
//  SoloProject
//
//  Created by Ramu on 2/19/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit

final class ImageCache {
    private init() {}
    
    static let shared = ImageCache()
    
    private static var cache = NSCache<NSString, UIImage>()
    
    public func fetchImageFromNetwork(urlString: String, completion: @escaping (AppError?, UIImage?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data ) in
            if let appError = appError {
                DispatchQueue.main.async {
                    completion(appError, nil)
                }
            } else if let data = data {
                DispatchQueue.global().async {
                    if let image = UIImage(data: data) {
                        ImageCache.cache.setObject(image, forKey: urlString as NSString)
                        DispatchQueue.main.async {
                            completion(nil, image)
                        }
                    }
                }
            }
        }
    }
    
    public func fetchImageFromCache(urlString: String) -> UIImage? {
        return ImageCache.cache.object(forKey: urlString as NSString)
    }
}

