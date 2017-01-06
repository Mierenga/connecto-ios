//
//  ConnectoSquare.swift
//  junctio
//
//  Created by Mike Swierenga on 12/24/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import UIKit

class ConnectoSquare {
    
    enum Compass: Int {
        case north, south, east, west
    }
    enum Word: String {
        case north, south, east, west
    }
    
    enum Shape: UInt32 {
        case blank, term, turn, fork, strat, cross
    }
    
    enum Position: Int {
        case corner, edge, inner
    }
    
    
    class Rotation {
        
        var degrees = 0
        var totalDegreesRotated = 0
        
        public func rotate(degrees: Int) {
            self.totalDegreesRotated += degrees
            self.degrees = reduceDegrees(self.degrees + degrees)
        }
        
        public func get() -> Int {
            return self.degrees
        }
        
        private func reduceDegrees(_ degrees: Int) -> Int {
            if degrees >= 360 {
                return reduceDegrees(degrees-360)
            }
            return degrees
        }
    }
    
    public static func getRandomSquare(_ position: Position, board: ConnectoBoard, i: Int, j: Int) -> ConnectoSquare {
        let square = ConnectoSquare(shape: getRandomShape(position), board: board, i: i, j: j)
        return square
    }
    
    public static func getRandomShape(_ position: Position) -> Shape {
        switch position {
        case .inner:
            return getRandomShape(lessThan: 6)
        case .edge:
            return getRandomShape(lessThan: 5)
        case .corner:
            return getRandomShape(lessThan: 3)
        }
    }
    
    private static func getRandomShape(lessThan: UInt32) -> Shape {
        
        let t = arc4random_uniform(lessThan)
        /*
        for _ in 0...1 {
            // if we get a terminal in the inner puzzle, roll again to reduce the chances
            //   terminals in inner puzzle
            if (t == UInt32(Shape.term.rawValue) || t == UInt32(Shape.blank.rawValue)) {
                t = arc4random_uniform(lessThan)
            } else {
                break
            }
        }
        */
        return Shape(rawValue: t)!
    }
    
    private var row = 0, col = 0
    private var north = false, east = false, south = false, west = false
    public private(set) var shape: Shape
    private weak var board: ConnectoBoard?
    public var rotation: Rotation
   
    init(shape: Shape, board: ConnectoBoard, i: Int, j: Int) {
        self.rotation = Rotation()
        self.shape = shape
        self.board = board
        self.row = i
        self.col = j
        switch shape {
        case .blank:
            return
        case .cross:
            self.north = true
            self.east = true
            self.west = true
            self.south = true
        case .strat:
            self.south = true
            self.north = true
        case .fork:
            self.north = true
            self.west = true
            self.east = true
        case .term:
            self.north = true
        case .turn:
            self.north = true
            self.west = true
        }
        print("created square: " + north.description + east.description + south.description + west.description)
    }
    
    /*
    convenience init (board: ConnectoBoard) {
        self.init(shape: .blank, board: board)
    }
 */
    
    public func skin() -> ConnectoSkin {
        return self.board!.skin
    }
    
    public func shapeName() -> String {
        switch self.shape {
        case .blank:
            return "blank"
        case .cross:
            return "cross"
        case .fork:
            return "fork"
        case .strat:
            return "strat"
        case .term:
            return "term"
        case .turn:
            return "turn"
        }
    }
    
    public func image() -> UIImage {
        return skin().getArt(self)
    }
    
    public func isBlank() -> Bool {
        return (getTrueSides() == 0)
    }
    
    public func isCross() -> Bool {
        return (getTrueSides() == 4)
    }
    
    public func isFork() -> Bool {
        return (getTrueSides() == 3)
    }
    
    public func isStraight() -> Bool {
        if (getTrueSides() == 2) {
            return self.north != self.south;
        }
        return false;
    }
    
    public func isTurn() -> Bool {
        if (getTrueSides() == 2) {
            return !isStraight();
        }
        return false;
    }
    
    
    public func getTrueSides() -> Int {
        var trueSides = 0;
        if self.north {
            trueSides+=1;
        }
        if self.east {
            trueSides+=1;
        }
        if self.south {
            trueSides+=1;
        }
        if self.west {
            trueSides+=1;
        }
        return trueSides;
    }
    
    public func rotateClockwise(degrees: Int) {
        
        self.rotation.rotate(degrees: degrees)
        var i = 0
        while i < degrees {
            let n = self.north;
            self.north = self.west;
            self.west = self.south;
            self.south = self.east;
            self.east = n;
            i += 90
        }
    }
    
    public func checkAllNeighbors() -> Bool {
        if (!checkNeighbor(Compass.east, doCheck: true)) { return false }
        if (!checkNeighbor(Compass.west, doCheck: true)) { return false }
        if (!checkNeighbor(Compass.north, doCheck: true)) { return false }
        if (!checkNeighbor(Compass.south, doCheck: true)) { return false }
        return true;
    }
    
    public func checkNeighbor(_ direction: Compass) -> Bool {
        return  checkNeighbor(direction, doCheck: true)
    }
    
    public func checkNeighbor(_ direction: Compass, doCheck: Bool) -> Bool {
        if !doCheck {
            return true
        }
        return compare(withNeighborTo: direction)
    }
    
    private func compare(withNeighborTo direction: Compass) -> Bool {
        let coords = getCoordinates(forNeighborTo: direction, myRow: self.row, myCol: self.col)
        let r = coords.0
        let c = coords.1
        var neighborVal = false
        if (r < self.board!.rows() && c < self.board!.cols() && r > -1 && c > -1) {
            let neighbor = self.board!.grid[r][c]
            neighborVal = neighbor.get(valueAt: getOpposite(direction: direction))
        }
        return neighborVal == self.get(valueAt: direction)
    }
    
    private func get(valueAt compass: Compass) -> Bool {
        switch compass {
        case .north:
            return self.north
        case .south:
            return self.south
        case .east:
            return self.east
        case .west:
            return self.west
        }
    }
    
    private func getOpposite(direction: Compass) -> Compass {
        switch direction {
        case .north:
            return .south
        case .south:
            return .north
        case .east:
            return .west
        case .west:
            return .east
        }
    }
    
    private func getCoordinates(forNeighborTo direction: Compass, myRow: Int, myCol: Int) -> (Int, Int) {
        switch direction {
        case .north:
            return (myRow - 1, myCol)
        case .south:
            return (myRow + 1, myCol)
        case .east:
            return (myRow, myCol + 1)
        case .west:
            return (myRow, myCol - 1)
        }
    }
    
    
}
