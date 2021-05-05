//
//  UIImageView+Cache.swift
//  Classify
//
//  Created by Arsalan Khan on 19/02/2021.
//

import UIKit
import Foundation

enum ImageDownloadError: Error {
    case invalidUrl
}

extension UIImageView {
    
    func setImage(_ url: URL) {
        
        let cache = MyCacheWrapper(URLCache.shared)
        
        let request = URLRequest(url: url)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let data = cache.cache.cachedResponse(for: request)?.data,
               let cachedImage = UIImage(data: data) {
               
                DispatchQueue.main.async {
                    self?.animate(cachedImage)
                }
                
            } else {
                URLSession.shared.dataTask(with: request) { (data, resp, err) in
                    
                    guard err == nil else {
                        return
                    }
                    
                    if let data = data,
                       let response = resp, (200..<206).contains(((resp as? HTTPURLResponse)?.statusCode ?? 500)),
                       let img = UIImage(data: data) {
                    
                        cache.cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
                        
                        DispatchQueue.main.async {
                            self?.animate(img)
                        }
                    }
                    
                }.resume()
            }
        }
    }
    
    func setImage(_ string: String) throws {
        
        guard let url = URL(string: string) else {
            throw ImageDownloadError.invalidUrl
        }
        
        setImage(url)
    }
    
    
    func animate(_ image: UIImage) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
            self.image = image
        } completion: { (_) in
            
        }

    }
}
