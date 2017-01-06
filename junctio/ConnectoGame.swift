//
//  ConnectoGame.swift
//  junctio
//
//  Created by Mike Swierenga on 12/31/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import Foundation

class ConnectoGame {
    public var board: ConnectoBoard
    public var skin: ConnectoSkin
    public var difficulty: ConnectoDifficulty
    
    init(skin: ConnectoSkin, difficulty: ConnectoDifficulty) {
        self.skin = skin
        self.difficulty = difficulty
        let dim = self.difficulty.puzzleDimensions()
        self.board = ConnectoBoard(rows: dim.0, cols: dim.1, skin: self.skin)
    }
    
    
}
