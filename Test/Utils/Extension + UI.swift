//
//  Extension.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
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
}

extension Date {
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    func toString() -> String {
        return self.dateFormatter.string(from: self as Date)
    }
}

extension Double {
    func currencyFormat() -> String {
        let intValue = Int(self)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "es_MX")
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        return numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
    }
}

