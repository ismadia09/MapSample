//
//  UIViewController + ChildViewController.swift
//  MapSample
//
//  Created by Isma Dia on 16/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChildViewController(_ childController: UIViewController, in subview: UIView) {
        
        guard let view = childController.view else {
            return
        }
        view.frame = subview.bounds
        //risize pour top bottom left right center etc
        view.autoresizingMask = UIViewAutoresizing(rawValue: 0b11111)
        // 2 eme methode view.autoresizingMask = [.flexibleBottomMargin,.flexibleHeight,.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleWidth]
        
        subview.addSubview(view)
        self.addChildViewController(childController)
    }
    
    func removeVisibleChildViewController(_ childController: UIViewController) {
        
        childController.removeFromParentViewController()
        childController.view.removeFromSuperview()
    }
}
