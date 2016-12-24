//
//  ConnectoViewCell.swift
//  junctio
//
//  Created by Mike Swierenga on 12/23/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit

class ConnectoViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    var angle: Int = 0
    
    public func rotate() {
        UIView.animate(withDuration: 0.4, animations: {
            self.image.transform = CGAffineTransform(rotationAngle: (CGFloat(M_PI)/2.0) * CGFloat(self.angle))//(90.0 * CGFloat(M_PI)) / 180.0)
        })
        self.angle+=1;
    }
}
