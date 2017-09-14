//
//  State.swift
//  ArtificialInteligence
//
//  Created by ifce on 08/09/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

struct Successor {
    private var key: String!
    private var cost: Int!
    private var heuristicCost: Int!
    
    init(key: String, cost: Int, heuristicCost: Int) {
        self.key = key
        self.cost = cost
        self.heuristicCost = heuristicCost
    }
    
    func getKey() -> String {
        return self.key
    }
    
    func getCost() -> Int {
        return self.cost
    }
    
    func getHeuristicCost() -> Int {
        return self.heuristicCost
    }
}

struct State {
    private var key: String!
    private var successors: [Successor]!
    
    init(key: String, successors: [Successor]) {
        self.key = key
        self.successors = successors
    }
    
    func getKey() -> String {
        return self.key
    }
    
    func getSuccessors() -> [Successor] {
        return self.successors
    }
}
