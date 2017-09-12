//
//  ViewController.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 18/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backPickerView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    let data = DataManager()
    var states: [State] = []
    var initialState: String!
    var finalState: String!
    var path: [String] = []
    var search: String!
    var searchs : [String] = ["Depth", "Breadth", "Bidirectional", "Uniformed"]
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
        self.backPickerView.layer.cornerRadius = 5
        self.backPickerView.clipsToBounds = true
        self.searchButton.layer.cornerRadius = 5
        self.searchButton.clipsToBounds = true
        pickerView.delegate = self
        pickerView.dataSource = self
        mapView.delegate = self
        let location = Location()
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.arad, 1550000, 1550000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func getCities() {
        let data = DataManager()
        states = data.getStates(from: .Romania).reversed()
        initialState = states.first?.getKey()
        finalState = states.first?.getKey()
        search = searchs.first
    }
    
    @IBAction func searchAction(_ sender: Any) {
        agent = Agent(initialState: initialState, finalState: finalState, states: states, problem: .Romania)
        
        switch search {
        case "Bidirectional":
            path = agent.problemSolvingWithBidirectionalSearch(.BreadthXDepth)
            break
        case "Depth":
            path = agent.problemSolvingWithDepthSearch()
            break
        case "Breadth":
            path = agent.problemSolvingWithBreadthSearch()
            break
        case "Uniformed":
            path = agent.problemSolvingWithUniformedSearch()
            break
        default:
            break
        }
        
        createAnnotations()
    }
    
    func createAnnotations() {
        self.mapView.removeAnnotations(mapView.annotations)
        for city in path {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString("\(city), Romênia") { placemarks, error in
                let placemark = placemarks?.first
                print(city)
                let lat = (placemark?.location?.coordinate.latitude)!
                let long = (placemark?.location?.coordinate.longitude)!
                let annotation = Annotation(location: CLLocationCoordinate2D(latitude: lat, longitude: long) , title: city)
                self.mapView.addAnnotation(annotation)
                self.mapView.setCenter(annotation.coordinate, animated: true)
            }
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Annotation {
            return annotation.annotationView
        } else {
            return nil
        }
    }
}
