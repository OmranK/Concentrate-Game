//
//  Card.swift
//  Concentrate
//
//  Created by Omran Khoja on 6/28/18.
//  Copyright © 2018 AcronDesign. All rights reserved.
//

import Foundation

struct Card {
    
    //API
    
    var isFaceUp = false
    var isMatched = false
    var isSeenBefore = false
    private(set) var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
