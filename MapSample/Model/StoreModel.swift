//
//  StoreModel.swift
//  MapSample
//
//  Created by Isma Dia on 08/12/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

extension StoreModel {
    func getCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
    }
}
