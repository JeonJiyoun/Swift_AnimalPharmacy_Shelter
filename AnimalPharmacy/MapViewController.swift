//
//  MapViewController.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/24.
//  Copyright © 2020 60080254. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var fullAddr : String = "주소"
    var lat: Double = 128.0
    var log: Double = 35.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = fullAddr
        
        /*map view*/
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: log)
        
        let center = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
}
