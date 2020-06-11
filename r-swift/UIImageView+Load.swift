//
//  UIImageView+Load.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-09.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

fileprivate var imagesCache = NSCache<NSString, UIImage>()

enum DataResponseError: Error {
    case network
}

extension UIImageView {
    func loadImage(from url: URL, completion: ((Result<UIImage, DataResponseError>) -> Void)? = nil) {
        if let cachedImage = imagesCache.object(forKey: url.absoluteString as NSString) {
            image = cachedImage
            completion?(Result.success(cachedImage))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion?(Result.failure(.network))
                    return
            }
            imagesCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                self.image = self.image == nil ? image : nil
            }
            completion?(Result.success(image))
        }.resume()
    }
}
