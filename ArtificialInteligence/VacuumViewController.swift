//
//  VacuumViewController.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 20/09/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class VacuumViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    let data = DataManager()
    var states: [State] = []
    var initialState: String!
    var finalState: String!
    var path: [String] = []
    var search: String!
    var searchs : [String] = ["Depth", "Breadth"]
    var agent: Agent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        states = data.getStates(from: .Romania)
        configurateController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configurateController() {
        getCities()
        self.button.layer.cornerRadius = 5
        self.button.clipsToBounds = true
        self.textView.layer.cornerRadius = 5
        self.textView.clipsToBounds = true
        self.textView.text = "Vacuum Cleaner Problem"
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func getCities() {
        let data = DataManager()
        states = data.getStates(from: .VacuumCleaner).reversed()
        initialState = states.first?.getKey()
        finalState = states.first?.getKey()
        search = searchs.first
    }
    
    @IBAction func searchAction(_ sender: Any) {
        agent = Agent(initialState: initialState, finalState: finalState, states: states, problem: .Romania)
        
        switch search {
        case "Depth":
            path = agent.problemSolvingWithDepthSearch()
            break
        case "Breadth":
            path = agent.problemSolvingWithBreadthSearch()
            break
        default:
            break
        }
        
        textView.text = "Romania Problem\n\(path)"
    }
}

extension VacuumViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 2 {
            return searchs.count
        }
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 2 {
            return searchs[row]
        }
        return states[row].getKey()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            initialState = states[row].getKey()
        } else if component == 1 {
            finalState = states[row].getKey()
        } else {
            search = searchs[row]
        }
    }
}
