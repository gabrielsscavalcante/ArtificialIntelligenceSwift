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
    var states: [String: [String]]
    var visited: [String] = []
    
    init(states: [String: [String]], finalState: String) {
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
            if state.key == node.state {
                for key in state.value {
                    let newNode = Node(state: key)
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
