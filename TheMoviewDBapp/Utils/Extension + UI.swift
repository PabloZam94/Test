//
//  Extension.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

extension UIView {
    func setGrdientVertical(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.2, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
var gradientLayer : CAGradientLayer!

extension UIImageView {
        
    func DownloadImgFromURL(uri : String) {
        let url = URL(string: uri)
        
        image = nil
        
        if let imageFormCache = imageCache.object(forKey: uri as AnyObject) as? UIImage {
            self.image = imageFormCache
           
            return
        }
        
        if url != nil {
            let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
                if error == nil {
                    if let data = responseData {
                        
                        DispatchQueue.main.async {
                            
                            let imageToCache = UIImage(data: data)
                            if imageToCache != nil {
                                imageCache.setObject(imageToCache!, forKey: uri as AnyObject)
                                self.image = imageToCache
                                
                            }
                                                      
                        }
                        
                    }else {
                        print("no data")
                    }
                }else{
                    print("error")
                }
            }
            task.resume()
        }
    }
    
    func addBottomShadow(shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, offset: CGSize) {
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offset
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
}
