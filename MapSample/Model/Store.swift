//
//  Store.swift
//  MapSample
//
//  Created by Isma Dia on 16/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import CoreLocation

public class Store {
    public let name : String
    public let coordinate : CLLocationCoordinate2D
    public let openingHours : String
    
    public init(name: String, coordinate: CLLocationCoordinate2D, openingHours : String){
        self.name = name
        self.coordinate = coordinate
        self.openingHours = openingHours
    }
}
