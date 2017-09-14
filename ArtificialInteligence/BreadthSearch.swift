//
//  BreadthSearch.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 18/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class BreadthSearch {
    
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
        
        print("\n\nBREADTH SEARCH")
        print("\nBorders:")
        
        if currentState == nil {
            currentState = Node(state: initialState)
        }
        
        while !searchManager.isGoalState(currentState, finalState) {
            self.addToBorder(getSucessors(from: currentState))
            self.visited.append(currentState.state)
            self.currentState = border.last
            self.border.removeLast()
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
                    successors.append(newNode)
                }
            }
        }
        
        return successors
    }
    
    func addToBorder(_ successors: [Node]) {
        if !visited.contains(currentState.state) {
            for successor in successors {
                self.border.appendAtBeginning(newItem:successor)
            }
        }
        
        print(currentState.state)
        searchManager.printBorder(border)
    }
}
