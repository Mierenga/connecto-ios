//
//  EasyDifficulty.swift
//  junctio
//
//  Created by Mike Swierenga on 12/30/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import Foundation

class EasyDifficulty: ConnectoDifficulty {
    
    func puzzleDimensions() -> (Int, Int) {
        return (4, 3)
    }
    
    func getNextDifficulty() -> ConnectoDifficulty {
        return IntermediateDifficulty()
    }
    
    func getTitle() -> String {
        return "Easy"
    }
    
}
