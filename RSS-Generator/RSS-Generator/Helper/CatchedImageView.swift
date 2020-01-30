//
//  CatchedImageView.swift
//  RSS-Generator
//
//  Created by zijia on 1/29/20.
//  Copyright © 2020 zijia. All rights reserved.
//

import UIKit


// Need SDWebImage/Kingfisher to help us doing the memory cahe and disk cahce in real project to imporve performance!

private var imageCache = [String: UIImage]()

class CatchedImageView: UIImageView {
    
    var spinnerView: UIView = {
        let spin = UIView()
        spin.backgroundColor = UIColor.white
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spin.center
        spin.addSubview(ai)
        return spin
    }()
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        
        lastURLUsedToLoadImage = urlString
        self.image = nil
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        self.addSubview(spinnerView)
        spinnerView.fillSuperview()
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage { return }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.spinnerView.removeFromSuperview()
                self.image = photoImage
            }
            
            }.resume()
    }
}
