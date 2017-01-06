//
//  AgedSkin.swift
//  junctio
//
//  Created by Mike Swierenga on 12/30/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit

class AgedSkin: ConnectoSkin {
    
    override init() {
        super.init()
        self.tiles = [#imageLiteral(resourceName: "blank_aged"), #imageLiteral(resourceName: "term_aged"), #imageLiteral(resourceName: "turn_aged"), #imageLiteral(resourceName: "fork_aged"), #imageLiteral(resourceName: "strat_aged"), #imageLiteral(resourceName: "cross_aged")]
    }
    
    override func getNextSkin() -> ConnectoSkin {
        return EyeSkin()
    }
    
    override func getBackground() -> Any {
        return UIColor(patternImage:#imageLiteral(resourceName: "blank_aged"))
    }
    
    override public func getTitle() -> String {
        return "Aged"
    }
    
}
