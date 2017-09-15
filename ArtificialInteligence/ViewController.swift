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
    var searchs : [String] = ["Depth", "Breadth", "Bidirectional", "Uniformed", "Greedy", "A*"]
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
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 46.1833333, longitude: 21.3166667), 1550000, 1550000)
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
        case "Greedy":
            if initialState == "Bucharest" || finalState == "Bucharest" {
                path = agent.problemSolvingWithGreedySearch()
            }
            break
        case "A*":
            if initialState == "Bucharest" || finalState == "Bucharest" {
                path = agent.problemSolvingWithAStarSearch()
            }
            break
        default:
            break
        }
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        getAnnotations(with: path) { (annotation) in
            self.mapView.addAnnotation(annotation)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) {
            _ in
            self.mapView.removeOverlays(self.mapView.overlays)
            self.getRoute(in: self.mapView)
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
    
    func getAnnotations(with path: [String], _ completation: @escaping (_ annotation: Annotation) -> ()) {
        for city in path {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString("\(city), Romania") { placemarks, error in
                let placemark = placemarks?.first
                print(city)
                if let lat = placemark?.location?.coordinate.latitude, let long = placemark?.location?.coordinate.longitude {
                    let annotation = Annotation(location: CLLocationCoordinate2D(latitude: lat, longitude: long) , title: city)
                    completation(annotation)
                }
            }
        }
    }
    
    func getRoute(in mapView: MKMapView) {
        let annotations = mapView.annotations
        for i in 0..<annotations.count-1 {
            let source = MKMapItem(placemark: MKPlacemark(coordinate: annotations[i].coordinate))
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: annotations[i+1].coordinate))
            let request = MKDirectionsRequest()
            request.source = source
            request.destination = destination
            request.requestsAlternateRoutes = false
            
            let directions = MKDirections(request: request)
            
            directions.calculate(completionHandler: {(response, error) in
                
                if error != nil {
                    print("Error getting directions")
                } else {
                    self.showRoute(response!)
                }
            })
        }
    }
    
    func showRoute(_ response: MKDirectionsResponse) {
        
        for route in response.routes {
            
            mapView.add(route.polyline,
                        level: MKOverlayLevel.aboveRoads)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
}
