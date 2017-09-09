//
//  Location.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 08/09/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreLocation

class Location {
    
    let arad = CLLocation(latitude: 46.1833333, longitude: 21.3166667)
    let zerind = CLLocation(latitude: 46.6166667, longitude: 21.5166667)
    let oradea = CLLocation(latitude: 47.0666667, longitude: 21.9333333)
    let timisoara = CLLocation(latitude: 45.7494444, longitude: 21.2272222)
    let lugoj = CLLocation(latitude: 45.68861, longitude: 21.90306)
    let sibiu = CLLocation(latitude: 45.8, longitude: 24.15)
    let mehadia = CLLocation(latitude: 44.9008300, longitude: 22.3669400)
    let drobeta = CLLocation(latitude: 44.6319444, longitude: 22.6561111)
    let vimnicuVilcea = CLLocation(latitude: 45.0996753, longitude: 24.3693179)
    let fagaras = CLLocation(latitude: 45.85, longitude: 24.9666667)
    let craiova = CLLocation(latitude: 44.3166667, longitude: 23.8)
    let pitesti = CLLocation(latitude: 44.85, longitude: 24.8666667)
    let giurgiu = CLLocation(latitude: 43.88333, longitude: 25.96667)
    let bucharest = CLLocation(latitude: 44.439663, longitude: 26.096306)
    let neamt = CLLocation(latitude: 46.9166700, longitude: 26.3333300)
    let urziceni = CLLocation(latitude: 44.71667, longitude: 26.63333)
    let iasi = CLLocation(latitude: 47.151726, longitude: 27.587914)
    let vaslui = CLLocation(latitude: 46.63333, longitude: 27.73333)
    let hirsova = CLLocation(latitude: 44.6857400, longitude: 27.9481900)
    let eforie = CLLocation(latitude: 44.0666667, longitude: 28.6333333)
    
    func from(_ city: String) -> CLLocation? {
        switch city {
        case RomaniaCities.Arad.rawValue:
            return arad
        default:
            return nil
        }
    }
}
