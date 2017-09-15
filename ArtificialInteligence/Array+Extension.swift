//
//  Array+Extension.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 19/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

extension Array{
    mutating func appendAtBeginning(newItem : Element){
        let copy = self
        self = []
        self.append(newItem)
        self.append(contentsOf: copy)
    }
}
