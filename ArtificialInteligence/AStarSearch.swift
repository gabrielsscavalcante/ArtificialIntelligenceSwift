//
//  A*Search.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 14/09/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class AStarSearch: SearchProtocol {
    
    var border: [Node] = []
    var currentState: Node!
    var finalState: String!
    var states: [State]
    var visited: [String] = []
    let searchManager = SearchManager()
    
    init(states: [State], finalState: String) {
        self.states = states
        self.finalState = finalState
    }
    
    func search(from initialState: String) -> [String] {
        
        print("\n\nA* SEARCH")
        print("\nBorders:")
        
        if currentState == nil {
            currentState = Node(state: initialState)
        }
        
        while !searchManager.isGoalState(currentState, finalState) {
            self.addToBorder(getSucessors(from: currentState))
            self.visited.append(currentState.state)
            self.currentState = border.first
            self.border.removeFirst()
        }
        
        return searchManager.getPath(currentState, finalState)
    }
    
    func getSucessors(from node: Node) -> [Node] {
        var successors: [Node] = []
        
        for state in states {
            if state.getKey() == node.state {
                for successor in state.getSuccessors() {
                    
                    let newNode = Node(state: successor.getKey())
                    newNode.setParent(node)
                    
                    let newCost = node.cost+successor.getCost()
                    newNode.setCost(newCost)
                    
                    let heuristicCost = successor.getHeuristicCost()
                    newNode.setHeuristicCost(heuristicCost)
                    
                    let totalCost = newCost + heuristicCost
                    newNode.setTotalCost(totalCost)
                    
                    successors.append(newNode)
                }
            }
        }
        
        return successors
    }
    
    func addToBorder(_ successors: [Node]) {
//        if !visited.contains(currentState.state) {
            let sortedSuccessors = successors.sorted{$0.0.totalCost > $0.1.totalCost}
            for successor in sortedSuccessors {
                self.border.appendAtBeginning(newItem:successor)
            }
//        }
        
        print(currentState.state)
        print(currentState.totalCost)
//        searchManager.printBorder(border)
    }
}

