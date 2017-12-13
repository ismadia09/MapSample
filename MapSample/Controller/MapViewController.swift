//
//  MapViewController.swift
//  MapSample
//
//  Created by Isma Dia on 15/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var locationManager : CLLocationManager!
    weak var storeProvider : StoreProvider?
    
    var lat = [48.872315, 48.8627862]
    var lon = [2.3311313, 2.332226]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
        //Utiliser la localisation
        if CLLocationManager.locationServicesEnabled(){
            let manager = CLLocationManager()
            manager.requestWhenInUseAuthorization()
            self.locationManager = manager
        }
        
        if let stores = storeProvider?.stores {
            mapView.addAnnotations(stores.map {$0.annotation})
        }
        
        // Montrer la localisation du telephone en code mais possible dans le xib
        //mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        
        
        let opera = MKPointAnnotation()
        opera.coordinate = .init(latitude: lat[0] , longitude: lon[0])
        opera.title = "Opera"
        opera.subtitle = "Ouverture 8h-22h"
        
        
       let louvre = MKPointAnnotation()
        louvre.coordinate = .init(latitude: lat[1], longitude:lon[1])
        louvre.title = "Louvre"
        louvre.subtitle = "Ouverture 8h-22h"
        mapView.addAnnotations([opera,louvre])
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.removeAnnotations(mapView.annotations)
        if let stores = storeProvider?.stores {
            mapView.addAnnotations(stores.map {$0.annotation})
        }
    }
    

}


extension Store{
    
    public var annotation: MKAnnotation {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = self.name
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        pointAnnotation.subtitle = self.openingHours
        return pointAnnotation
    }
}


//Affichage dans le delegate de la MAP
extension MapViewController: MKMapViewDelegate{
    
    public static let appleStoreId = "ASI"
    
    //Creer les vues pour les annotations
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //type de l'annotation pour le USER
        if annotation is MKUserLocation {
            return nil
        }
        
        
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: MapViewController.appleStoreId)
        if let reused = view {
            reused.annotation = annotation
            reused.canShowCallout = true
            return reused
        }
            //si la vue de la localisation n'existe pas
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier : MapViewController.appleStoreId)
            pin.canShowCallout = true
            pin.pinTintColor = .yellow
        
        
        return nil
    }
}
