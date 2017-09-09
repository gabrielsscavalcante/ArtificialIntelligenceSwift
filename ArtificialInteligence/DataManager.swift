//
//  DataManager.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 18/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreLocation

enum KindOfProblem: String {
    case Romania = "RomaniaRoutes"
    case VacuumCleaner = "WorldOfVacuumCleaner"
}

enum RomaniaCities: String {
    case Arad = "Arad"
    case Zerind = "Zerind"
    case Bucharest = "Bucharest"
    case Oradea = "Oradea"
    case Timisoara = "Timisoara"
    case Sibiu = "Sibiu"
    case Lugoj = "Lugoj"
    case Mehadia = "Mehadia"
    case Dobreta = "Dobreta"
    case Craiova = "Craiova"
    case Rimnicu_Vilcea = "Rimnicu Vilcea"
    case Pitesti = "Pitesti"
    case Fagaras = "Fagaras"
    case Giurgiu = "Giurgiu"
    case Urziceni = "Urziceni"
    case Hirsova = "Hirsova"
    case Vaslui = "Vaslui"
    case Iasi = "Iasi"
    case Neamt = "Neamt"
}

class DataManager {
    
    func getStates(from problem: KindOfProblem) -> [State] {
        let datas = readTextWithCost(from: problem.rawValue) as! [String: [[String: Int]]]
        
        var states: [State] = []
        
        for data in datas {
            var state: State!
            var successors: [Successor] = []
            for key in data.value {
                var successor: Successor!
                for value in key {
                    successor = Successor(key: value.key, cost: value.value)
                    successors.append(successor)
                }
                state = State(key: data.key, successors: successors)
            }
            states.append(state)
        }
        
        return states
    }
    
    func readText(from fileName: String) -> [String: Any]? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                return self.convertToDictionary(text: data)
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func readTextWithCost(from fileName: String) -> [String: Any]? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                return self.convertToDictionary(text: data)
            } catch {
                print(error)
            }
        }
        return nil
    }
}
