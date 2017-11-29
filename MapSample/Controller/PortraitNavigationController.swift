//
//  PortraitNavigationController.swift
//  MapSample
//
//  Created by Isma Dia on 15/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import UIKit

public class PortraitNavigationController: UINavigationController{
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return
            self.visibleViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
}
