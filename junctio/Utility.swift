//
//  Utility.swift
//  junctio
//
//  Created by Mike Swierenga on 12/29/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit

// Global utility functions

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

extension UIImage {
    convenience init(view: UIView) {
        
        var bv: UIView?
        if let cv = view as? UICollectionView {
            
            bv = cv.backgroundView
            cv.backgroundView = nil
        }
        
        view.backgroundColor =
            view.backgroundColor?.withAlphaComponent(0.0)
        UIGraphicsBeginImageContext(view.frame.size)
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        view.backgroundColor =
            view.backgroundColor?.withAlphaComponent(1.0)
        
        if let cv = view as? UICollectionView {
            
            cv.backgroundView = bv
        }
        
        self.init(cgImage: image!.cgImage!)
    }
}
