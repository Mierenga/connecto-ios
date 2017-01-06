//
//  ConnectoSkin.swift
//  junctio
//
//  Created by Mike Swierenga on 12/30/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit

class ConnectoSkin {
    
    var tiles: [UIImage] = []
    
    public func getArt(_ square: ConnectoSquare) -> UIImage {
        return self.tiles[Int(square.shape.rawValue)]
    }
    
    public func getNextSkin() -> ConnectoSkin {
        preconditionFailure("This method must be overridden")
    }
    public func getBackground() -> Any {
        preconditionFailure("This method must be overridden")
    }
    
    public func getTitle() -> String {
        preconditionFailure("This method must be overridden")
    }
}
