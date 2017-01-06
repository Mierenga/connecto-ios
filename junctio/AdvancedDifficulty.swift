//
//  AdvancedDifficulty.swift
//  junctio
//
//  Created by Mike Swierenga on 12/30/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import Foundation

class AdvancedDifficulty: ConnectoDifficulty {

    func puzzleDimensions() -> (Int, Int) {
        return (11, 7)
    }
    
    func getNextDifficulty() -> ConnectoDifficulty {
        return SimpleDifficulty()
    }
    
    func getTitle() -> String {
        return "Advanced"
    }
    
}
