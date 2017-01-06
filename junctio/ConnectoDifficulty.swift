//
//  ConnectoDifficulty.swift
//  junctio
//
//  Created by Mike Swierenga on 12/21/16.
//  Copyright © 2016 eskimwier. All rights reserved.
//

import Foundation

protocol ConnectoDifficulty {
    func puzzleDimensions() -> (Int, Int);
    func getNextDifficulty() -> ConnectoDifficulty;
    func getTitle() -> String;
}
