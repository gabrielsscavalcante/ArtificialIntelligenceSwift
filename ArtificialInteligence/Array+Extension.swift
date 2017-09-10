//
//  Array+Extension.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 19/07/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension Array{
    mutating func appendAtBeginning(newItem : Element){
        let copy = self
        self = []
        self.append(newItem)
        self.append(contentsOf: copy)
    }
}
extension UIImage {
    func imageResize (sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}

class Route {
    
    func getRouteFor(
        source: CLLocationCoordinate2D,
        destination: CLLocationCoordinate2D,
        completion: @escaping (
        
        _ route: MKRoute?,
        _ error: String?)->()
        
        ) {
        
        let sourceLocation = CLLocation(
            
            latitude: source.latitude,
            longitude: source.longitude
            
        )
        
        let destinationLocation = CLLocation(
            
            latitude: destination.latitude,
            longitude: destination.longitude
            
        )
        
        let request = MKDirectionsRequest()
        
        self.getMapItemFor(location: sourceLocation) { sourceItem, error in
            
            if let e = error {
                
                completion(nil, e)
                
            }
            
            if let s = sourceItem {
                
                self.getMapItemFor(location: destinationLocation) { destinationItem, error in
                    
                    if let e = error {
                        
                        completion(nil, e)
                        
                    }
                    
                    if let d = destinationItem {
                        
                        request.source = s
                        
                        request.destination = d
                        
                        request.transportType = .walking
                        
                        let directions = MKDirections(request: request)
                        
                        directions.calculate(completionHandler: { response, error in
                            
                            if let r = response {
                                
                                let route = r.routes[0]
                                
                                completion(route, nil)
                                
                            }
                            
                        })
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func getMapItemFor(
        location: CLLocation,
        completion: @escaping (
        
        _ placemark: MKMapItem?,
        _ error: String?)->()
        
        ) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemark, error in
            
            if let e = error {
                
                completion(nil, e.localizedDescription)
                
            }
            
            if let p = placemark {
                
                if p.count < 1 {
                    
                    completion(nil, "placemark count = 0")
                    
                } else {
                    
                    if let mark = p[0] as? MKPlacemark {
                        
                        completion(MKMapItem(placemark: mark), nil)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
