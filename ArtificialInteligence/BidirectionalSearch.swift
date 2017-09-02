//
//  BidirectionalSearch.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 01/09/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

enum BidirectionalType {
    case DepthXBreadth
    case DepthXDepth
    case BreadthXDepth
    case BreadthXBreadth
}

class BidirectionalSearch {
    
    var border1: [Node] = []
    var border2: [Node] = []
    var currentState1: Node!
    var currentState2: Node!
    var visited1: [String] = []
    var visited2: [String] = []
    var states: [String: [String]] = [:]
    var finalState: String!
    var bidirectionalType: BidirectionalType
    
    init(states: [String: [String]], finalState: String, bidirectionalType: BidirectionalType) {
        self.states = states
        self.finalState = finalState
        self.bidirectionalType = bidirectionalType
    }
    
    func isGoalState() -> Bool {
        if currentState1.state == currentState2.state || currentState1.state == finalState {
            return true
        } else {
            return false
        }
    }
    
    func search(from initialState: String) -> [String] {
        
        if currentState1 == nil {
            currentState1 = Node(state: initialState)
        }
        
        if currentState2 == nil {
            currentState2 = Node(state: finalState)
        }
        
        while !isGoalState() {
            self.addToBorders(getSucessors(from: currentState1), getSucessors(from: currentState2))
            self.visited1.append(currentState1.state)
            self.visited2.append(currentState1.state)
            self.removeFromBorders()
        }
        
        return []//getPath()
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
    
    func addToBorders(_ successors: [Node], _ predecessors: [Node]) {
        if !visited1.contains(currentState1.state) {
            for successor in successors {
                self.border1.appendAtBeginning(newItem:successor)
            }
        }
        
        if !visited2.contains(currentState2.state) {
            for predecessor in predecessors {
                self.border2.appendAtBeginning(newItem:predecessor)
            }
        }
        
        print(currentState1.state)
        print(currentState2.state)
        printBorders()
    }
    
    func removeFromBorders() {
        switch self.bidirectionalType {
        case .BreadthXBreadth:
            self.currentState1 = border1.last
            self.border1.removeLast()
            self.currentState2 = border2.last
            self.border2.removeLast()
            break
        case .BreadthXDepth:
            self.currentState1 = border1.last
            self.border1.removeLast()
            self.currentState2 = border2.first
            self.border2.removeFirst()
            break
        case .DepthXBreadth:
            self.currentState1 = border1.first
            self.border1.removeFirst()
            self.currentState2 = border2.last
            self.border2.removeLast()
            break
        case .DepthXDepth:
            self.currentState1 = border1.first
            self.border1.removeFirst()
            self.currentState2 = border2.first
            self.border2.removeFirst()
            break
        default:
            break
        }
    }
    
//    func getPath() -> [String] {
//        var path: [String] = []
//        path.append(finalState)
//        var node = currentState
//        repeat {
//            if node!.parent != nil {
//                path.append(node!.parent!.state)
//                node = node!.parent
//            }
//        } while(node!.parent != nil)
//        
//        print("\nPath:")
//        return path
//    }
    
    func printBorders() {
        var statesBorder1:[String] = []
        var statesBorder2:[String] = []
        
        for node in border1 {
            statesBorder1.append(node.state)
        }
        
        for node in border2 {
            statesBorder2.append(node.state)
        }
        
        print(statesBorder1)
        print(statesBorder2)
        print("")
    }
}
