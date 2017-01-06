
//
//  ConnectoBoard.swift
//  junctio
//
//  Created by Mike Swierenga on 12/24/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import Foundation

class ConnectoBoard {
    
    
    public private(set) var grid: [[ConnectoSquare]]
    public var skin: ConnectoSkin
    private var invalid: [[[String]]]
    
    init(rows: Int, cols: Int, skin: ConnectoSkin) {
        self.grid = [[ConnectoSquare]](repeating: [ConnectoSquare](), count: rows)
        self.invalid = [[[String]]](repeating: [[String]](repeating: [String](), count: cols), count: rows)
        self.skin = skin
        generatePieces(rows: rows, cols:cols)
    }
    
    public func skin(_ skin: ConnectoSkin) {
        self.skin = skin
    }
    
    public func rows() -> Int {
        return self.grid.count
    }
    
    public func cols() -> Int {
        return self.grid[0].count
    }
    
    private func generatePieces(rows:Int, cols: Int) {
        fillWithBlanks(rows: rows, cols: cols)
        recursivelyCheckTiles(i: 0, j: 0)
    }
    
    private func recursivelyCheckTiles(i: Int, j: Int) {
        
        let hasSouthernNeighbor = (i < self.rows()-1);
        let hasEasternNeighbor = (j < self.cols()-1);
        
        
        // If it's the first one in it's row
        if j == 0 {
            swapSquare(i: i, j: j);
        }
        
        if hasEasternNeighbor {
            swapSquare(i: i, j: j+1);
            recursivelyCheckTiles(i: i, j:j+1);
        } else if hasSouthernNeighbor {
            recursivelyCheckTiles(i: i+1, j: 0);
        }
    }
    
    private func swapSquare(i: Int, j: Int) {
        let square: ConnectoSquare = getRandomSquare(i: i, j: j)
        self.grid[i][j] = square;
    }
    
    private func getRandomSquare(i: Int, j: Int) -> ConnectoSquare {
        var square: ConnectoSquare
        
        
        // corners
        if (i==0 && j==0) {
            square = getValidCorner(vert: ConnectoSquare.Compass.north, horiz: ConnectoSquare.Compass.west, i: i, j: j);
        } else if (i==0 && j==cols()-1) {
            square = getValidCorner(vert: ConnectoSquare.Compass.north, horiz: ConnectoSquare.Compass.east, i: i, j: j);
        } else if (i==rows()-1 && j==0) {
            square = getValidCorner(vert: ConnectoSquare.Compass.south, horiz: ConnectoSquare.Compass.west, i: i, j: j);
        } else if (i==rows()-1 && j==cols()-1) {
            square = getValidCorner(vert: ConnectoSquare.Compass.south, horiz: ConnectoSquare.Compass.east, i: i, j: j);
            
        // edges
        } else if (i==0) {
            square = getValidEdge(edge: ConnectoSquare.Compass.north, i: i, j: j);
        } else if (j==0) {
            square = getValidEdge(edge: ConnectoSquare.Compass.west, i: i, j: j);
        } else if (i==rows()-1) {
            square = getValidEdge(edge: ConnectoSquare.Compass.south, i: i, j: j);
        } else if (j==cols()-1) {
            square = getValidEdge(edge: ConnectoSquare.Compass.east, i: i, j: j);
            
        // inner
        } else {
            square = getValidInner(i: i, j: j);
        }
        
        return square
    }
    
    private func getValidInner(i: Int, j: Int) -> ConnectoSquare {
        return getValidInner(i: i, j: j, invalid: NSMutableArray(capacity: 4))
    }
    private func getValidEdge(edge: ConnectoSquare.Compass, i: Int, j: Int) -> ConnectoSquare {
        return getValidEdge(edge, i: i, j: j, invalid: NSMutableArray(capacity: 4))
    }
    
    private func getValidCorner(vert: ConnectoSquare.Compass, horiz: ConnectoSquare.Compass, i: Int, j: Int) -> ConnectoSquare {
        return getValidCorner(vert: vert, horiz: horiz, i: i, j: j, invalid: NSMutableArray(capacity: 4))
    }
    
    private func getValidInner(i: Int, j: Int, invalid: NSMutableArray) -> ConnectoSquare {
        let pos = ConnectoSquare.Position.inner
        var square = ConnectoSquare.getRandomSquare(pos, board: self, i: i, j: j)
        while invalid.contains(square.shapeName()) {
            square = ConnectoSquare.getRandomSquare(pos, board: self, i: i, j: j)
        }
        let checkSouth = false
        let checkEast = false
        
        if isValidPiece(square: square, checkSouth: checkSouth, checkEast: checkEast)  {
            print("valid INNER " + square.shapeName())
            return chooseValidOrientation(square: square, checkSouth: checkSouth, checkEast: checkEast, position: pos)
        } else {
            invalid.add(square.shapeName())
        }
        return getValidInner(i: i, j: j, invalid:invalid)
    }
    
    private func getValidEdge(_ edge: ConnectoSquare.Compass, i: Int, j: Int, invalid: NSMutableArray) -> ConnectoSquare {
        let pos = ConnectoSquare.Position.edge
        var square = ConnectoSquare.getRandomSquare(pos, board: self, i: i, j: j)
        while invalid.contains(square.shapeName()) {
            square = ConnectoSquare.getRandomSquare(pos, board: self, i: i, j: j)
        }
        let checkSouth = (edge == ConnectoSquare.Compass.south)
        let checkEast = (edge == ConnectoSquare.Compass.east)
        
        if isValidPiece(square: square, checkSouth: checkSouth, checkEast: checkEast)  {
            print("valid EDGE " + square.shapeName())
            return chooseValidOrientation(square: square, checkSouth: checkSouth, checkEast: checkEast, position: pos)
        } else {
            invalid.add(square.shapeName())
        }
        return getValidEdge(edge, i: i, j: j, invalid: invalid)
   }
    
    private func getValidCorner(vert: ConnectoSquare.Compass, horiz: ConnectoSquare.Compass, i: Int, j: Int, invalid: NSMutableArray) -> ConnectoSquare {
        let pos = ConnectoSquare.Position.corner
        var square = ConnectoSquare.getRandomSquare(pos, board: self, i: i, j: j)
        while invalid.contains(square.shapeName()) {
            square = ConnectoSquare.getRandomSquare(pos, board: self, i: i, j: j)
        }
          
        let isFirstCorner = (vert == ConnectoSquare.Compass.north && horiz == ConnectoSquare.Compass.west)
        let checkSouth = (vert == ConnectoSquare.Compass.south)
        let checkEast = (horiz == ConnectoSquare.Compass.east)
        
        if isFirstCorner || isValidPiece(square: square, checkSouth: checkSouth, checkEast: checkEast)  {
            print("valid CORNER " + square.shapeName())
            return chooseValidOrientation(square: square, checkSouth: checkSouth, checkEast: checkEast, position: pos)
        } else {
            invalid.add(square.shapeName())
        }
        return getValidCorner(vert: vert, horiz: horiz, i: i, j: j, invalid: invalid)
    }
    
    private func isValidPiece(square: ConnectoSquare, checkSouth: Bool, checkEast: Bool) -> Bool {
        
        // try all the orientations (until we find one that fits)
        for i in 0..<4 {
            print("  > try orientation: " + i.description)
            if (checkNeighbors(square: square, checkSouth: checkSouth, checkEast: checkEast)) {
                print("orientation ", i.description, " confirmed")
                return true;
            }
            square.rotateClockwise(degrees: 90)
        }
        print("no orientations fit!")
        return false;
        
    }
    
    private func chooseValidOrientation(square: ConnectoSquare, checkSouth: Bool, checkEast: Bool, position: ConnectoSquare.Position) -> ConnectoSquare {
        print("== Choosing orientation")
        while (true) {
            if (checkNeighbors(square: square, checkSouth: checkSouth, checkEast: checkEast)) {
                if (getChance(position: position, shape: square.shape)){
                    print("  +chosen")
                    return square
                }
            }
            print("  -rotate")
            square.rotateClockwise(degrees: 90)
        }
    }
    
    public func checkNeighbors(square: ConnectoSquare, checkSouth: Bool, checkEast: Bool) -> Bool {
        return (square.checkNeighbor(ConnectoSquare.Compass.west) &&
            square.checkNeighbor(ConnectoSquare.Compass.north) &&
            square.checkNeighbor(ConnectoSquare.Compass.east, doCheck: checkEast) &&
            square.checkNeighbor(ConnectoSquare.Compass.south, doCheck: checkSouth))
    }
    
    private func getChance(position: ConnectoSquare.Position, shape: ConnectoSquare.Shape) -> Bool {
        // TODO specify chance based on position
        return true
    }
    
    private func fillWithBlanks(rows: Int, cols: Int) {
        for i in 0..<rows {
            for j in 0..<cols {
                let shape = ConnectoSquare.Shape.blank
                grid[i].append(ConnectoSquare(shape: shape, board: self, i: i, j: j))
            }
        }
    }
    
    public func forEachSquare(_ closure: (ConnectoSquare) -> ()) {
        for row in self.grid {
            for square in row {
                closure(square)
            }
        }
    }
    
    public func checkIfSolved() -> Bool {
        for row in self.grid {
            for square in row {
                //if !square.checkAllNeighbors() {
                if !self.checkNeighbors(square: square, checkSouth: true, checkEast: true) {
                    return false
                }
            }
        }
        return true
    }
    
    
}
