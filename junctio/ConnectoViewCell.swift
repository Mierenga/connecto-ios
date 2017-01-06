//
//  ConnectoViewCell.swift
//  junctio
//
//  Created by Mike Swierenga on 12/23/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit

class ConnectoViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    
    var square : ConnectoSquare?
    
    private func getOrientation(_ degrees: Int) -> UIImageOrientation {
        switch degrees {
        case 90: return UIImageOrientation.right
        case 180: return UIImageOrientation.down
        case 270: return UIImageOrientation.left
        default: return UIImageOrientation.up
        }
    }
    public func setImage(img: UIImage) {
        self.img?.image = img
        self.normalOrientation()
    }
    
    public func setToModel(square: ConnectoSquare, jumble: Bool) {
        
        self.square = square
        
        var degrees = self.square!.rotation.get()
        let img = self.square!.image()
        print("  degrees: ", degrees, ", imageOrientation: ", img.imageOrientation.rawValue)
        
        self.img?.image = img
        while (degrees > 0) {
            rotate()
            degrees -= 90
        }
        
        if jumble {
            self.jumble()
        }
    }
    
    private func jumble() {
        let rotations = arc4random_uniform(4) + 4
        for _ in 0..<rotations {
            rotate()
        }
    }
    
    public func rotate() {
        //self.angle = (self.angle + 1) % 4;
        self.square!.rotateClockwise(degrees: 90)
        rotateView()
    }
    private func normalOrientation() {
        self.img!.transform = CGAffineTransform(rotationAngle: 0)
    }
    
    private func rotateView() {
        UIView.animate(withDuration: 0.2, animations: {
            let degrees = CGFloat(self.square!.rotation.get())
            //self.img!.transform = CGAffineTransform(rotationAngle: (CGFloat(M_PI)/2.0) * CGFloat(self.angle))//(90.0 * CGFloat(M_PI)) / 180.0)
            print(degrees)
            self.img!.transform = CGAffineTransform(rotationAngle: (degrees * CGFloat(M_PI)) / 180.0)
        })
    }
    
}
