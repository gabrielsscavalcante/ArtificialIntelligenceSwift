//
//  ViewController.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 18/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let data = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialState = RomaniaCities.Arad.rawValue
        let finalState = RomaniaCities.Bucharest.rawValue
        let problem = KindOfProblem.Romania
        let states = data.getData(from: problem)
        
        let agent = Agent(initialState: initialState, finalState: finalState, states: states, problem: problem)
        
        print(agent.problemSolvingWithBreadthSearch())
        print(agent.problemSolvingWithDepthSearch())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

