//
//  IntermediateDifficulty.swift
//  junctio
//
//  Created by Mike Swierenga on 12/30/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import Foundation

class IntermediateDifficulty: ConnectoDifficulty {
    
    func puzzleDimensions() -> (Int, Int) {
        return (8, 5)
    }
    
    func getNextDifficulty() -> ConnectoDifficulty {
        return AdvancedDifficulty()
    }
    
    func getTitle() -> String {
        return "Intermediate"
    }
}
