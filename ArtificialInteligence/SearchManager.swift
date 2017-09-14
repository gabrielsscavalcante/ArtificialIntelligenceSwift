//
//  SearchManager.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 14/09/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class SearchManager {
    
    func getPath(_ currentState: Node, _ finalState: String) -> [String] {
        var path: [String] = []
        path.append(finalState)
        var node = currentState
        repeat {
            if node.parent != nil {
                path.append(node.parent!.state)
                node = node.parent!
            }
        } while(node.parent != nil)
        
        print("\nPath:")
        return path
    }
    
    func isGoalState(_ node: Node, _ finalState: String) -> Bool {
        if node.state == finalState {
            return true
        } else {
            return false
        }
    }
    
    func printBorder(_ border: [Node]) {
        var statesBorder:[String] = []
        for node in border {
            statesBorder.append(node.state)
        }
        
        print(statesBorder)
    }
}
