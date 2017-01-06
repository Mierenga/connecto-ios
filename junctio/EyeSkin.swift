//
//  EyeSkin.swift
//  junctio
//
//  Created by Mike Swierenga on 12/30/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit

class EyeSkin: ConnectoSkin {
    
    override init() {
        super.init()
        self.tiles = [#imageLiteral(resourceName: "blank_eye"), #imageLiteral(resourceName: "term_eye"), #imageLiteral(resourceName: "turn_eye"), #imageLiteral(resourceName: "fork_eye"), #imageLiteral(resourceName: "strat_eye"), #imageLiteral(resourceName: "cross_eye")]
    }
    
    override func getNextSkin() -> ConnectoSkin {
        return SpectroSkin()
    }
    
    
    override func getBackground() -> Any {
        return UIColor.darkGray
    }
    
    override public func getTitle() -> String {
        return "Eye"
    }
}

