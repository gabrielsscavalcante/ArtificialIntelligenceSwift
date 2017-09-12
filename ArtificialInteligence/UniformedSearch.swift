//
//  BreadthSearch.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 18/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class UniformedSearch {
    
    var border: [Node] = []
    var currentState: Node!
    var finalState: String!
    var states: [State]
    var visited: [String] = []
    var cost:Int = 0
    
    init(states: [State], finalState: String) {
        self.states = states
        self.finalState = finalState
    }
    
    func isGoalState(_ node: Node) -> Bool {
        if node.state == finalState {
            return true
        } else {
            return false
        }
    }
    
    func search(from initialState: String) -> [String] {
        
        print("\n\nBREADTH SEARCH")
        print("\nBorders:")
        
        if currentState == nil {
            currentState = Node(state: initialState)
        }
        
        while !isGoalState(currentState) {
            self.addToBorder(getSucessors(from: currentState))
            self.visited.append(currentState.state)
            self.currentState = border.last
            self.border.removeLast()
        }
        
        return getPath()
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
        
        self.border.sort(by: {$0.0.cost > $0.1.cost})
        
        print(currentState.state)
        print(currentState.cost)
        printBorder()
    }
    
    func getPath() -> [String] {
        var path: [String] = []
        path.append(finalState)
        var node = currentState
        repeat {
            if node!.parent != nil {
                path.append(node!.parent!.state)
                node = node!.parent
            }
        } while(node!.parent != nil)
        
        print("\nPath:")
        print(path)
        return path
    }
    
    func printBorder() {
        var statesBorder:[String] = []
        for node in border {
            statesBorder.append(node.state)
        }
        print(statesBorder)
    }
}
