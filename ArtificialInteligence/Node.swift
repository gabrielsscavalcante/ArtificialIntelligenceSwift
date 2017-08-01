//
//  Node.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 18/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class Node {
    var parent: Node?
    var state: String = ""
    var successors = [Node]()
    
    init(state: String) {
        self.state = state
    }
    
    func setParent(_ node: Node) {
        self.parent = node
    }
    
    func setSuccessors(_ successors: [Node]) {
        self.successors = successors
    }
}
