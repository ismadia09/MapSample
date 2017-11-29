//
//  StoreProvider.swift
//  MapSample
//
//  Created by Isma Dia on 16/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import Foundation

public protocol StoreProvider: class {
    
    var stores : [Store] {get}
}
