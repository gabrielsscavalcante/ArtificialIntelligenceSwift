//
//  Agent.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 18/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class Agent {
    
    var initialState: String!
    var finalState: String!
    var states: [State]!
    var problem: KindOfProblem!
    
    var successor: [Node]? = nil
    var cost: Int = 0
    
    init(initialState: String, finalState: String, states: [State], problem: KindOfProblem) {
        self.initialState = initialState
        self.finalState = finalState
        self.states = states
        self.problem = problem
    }
    
    func problemSolvingWithBreadthSearch() -> [String] {
        let breadthSearch = BreadthSearch(states: states, finalState: finalState)
        
        return breadthSearch.search(from: initialState)
    }

    func problemSolvingWithDepthSearch() -> [String] {
        let depthSearch = DepthSearch(states: states, finalState: finalState)
        
        return depthSearch.search(from: initialState)
    }

    func problemSolvingWithBidirectionalSearch(_ type: BidirectionalType) -> [String] {
        let bidirectionalSearch = BidirectionalSearch(states: states,initialState: initialState, finalState: finalState, bidirectionalType: type)
        
        return bidirectionalSearch.search()
    }
    
    func problemSolvingWithUniformedSearch() -> [String] {
        let uniformedSearch = UniformedSearch(states: states, finalState: finalState)
        
        return uniformedSearch.search(from: initialState)
    }
    
    func problemSolvingWithGreedySearch() -> [String] {
        let greedySearch = GreedySearch(states: states, finalState: finalState)
        
        return greedySearch.search(from: initialState)
    }
    
    func problemSolvingWithAStarSearch() -> [String] {
        let aStarSearch = AStarSearch(states: states, finalState: finalState)
        
        return aStarSearch.search(from: initialState)
    }
}
