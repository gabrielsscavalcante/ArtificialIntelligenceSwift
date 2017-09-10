//
//  Annotation.swift
//  ArtificialInteligence
//
//  Created by Gabriel Cavalcante on 10/09/17.
//  Copyright © 2017 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import MapKit

class Annotation : NSObject, MKAnnotation {
    dynamic var coordinate : CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var key: String?
    var image: UIImage?
    
    init(location coord:CLLocationCoordinate2D, title: String) {
        self.coordinate = coord
        self.title = title
        super.init()
    }
    
    var annotationView : MKAnnotationView? {
        return defaultView()
    }
    
    func defaultView() -> MKAnnotationView {
        let view = MKAnnotationView(annotation: self, reuseIdentifier: "myCustomAnnotation")
        view.isEnabled = true
        let pinImage = UIImage(named: "pin")!
        view.image = pinImage.imageResize(sizeChange: CGSize(width: 65, height: 50))
        view.canShowCallout = true
        
        return view
    }
}
