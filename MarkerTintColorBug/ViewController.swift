//
//  ViewController.swift
//  MarkerTintColorBug
//
//  Created by Görkem Güclü on 20.06.23.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let applePark = CLLocationCoordinate2D(latitude: 37.335452, longitude: -122.008816)
        
        self.mapView.register(MarkerView.self, forAnnotationViewWithReuseIdentifier: "bus")
        self.mapView.centerCoordinate = applePark
        self.mapView.delegate = self

        let annotation = MKPointAnnotation()
        annotation.coordinate = applePark
        annotation.title = "Bus"
        self.mapView.addAnnotation(annotation)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        return mapView.dequeueReusableAnnotationView(withIdentifier: "bus", for: annotation)
    }
}

class MarkerView: MKMarkerAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        update()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        update()
    }
    
    func update() {
        if isSelected {
            self.image = nil
            self.glyphText = "BUS"
            self.markerTintColor = .blue
        }else{
            self.image = UIImage(systemName: "bus")
            self.glyphText = ""
            self.markerTintColor = .clear
        }
    }
}
