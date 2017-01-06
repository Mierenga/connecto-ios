//
//  SimpleDifficulty.swift
//  junctio
//
//  Created by Mike Swierenga on 12/30/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import Foundation

class SimpleDifficulty: ConnectoDifficulty {
    
    func puzzleDimensions() -> (Int, Int) {
        return (2, 2)
    }
    
    func getNextDifficulty() -> ConnectoDifficulty {
        return EasyDifficulty()
    }
    
    func getTitle() -> String {
        return "Simple"
    }
    
}
