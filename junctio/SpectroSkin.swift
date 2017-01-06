//
//  SpectroSkin.swift
//  junctio
//
//  Created by Mike Swierenga on 12/30/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit


class SpectroSkin: ConnectoSkin {
    
    override init() {
        super.init()
        self.tiles = [#imageLiteral(resourceName: "blank_spectro"), #imageLiteral(resourceName: "term_spectro"), #imageLiteral(resourceName: "turn_spectro"), #imageLiteral(resourceName: "fork_spectro"), #imageLiteral(resourceName: "strat_spectro"), #imageLiteral(resourceName: "cross_spectro")]
    }
    
    override func getNextSkin() -> ConnectoSkin {
        return AgedSkin()
    }
    
    override func getBackground() -> Any {
        return UIImageView(image:#imageLiteral(resourceName: "chandra"))
        //return UIColor.black
    }
    
    override public func getTitle() -> String {
        return "Spectro"
    }
    
}
