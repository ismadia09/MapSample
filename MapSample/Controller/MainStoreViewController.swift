//
//  MainStoreViewController.swift
//  MapSample
//
//  Created by Isma Dia on 16/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import UIKit
import CoreData


class MainStoreViewController: UIViewController, StoreProvider {
    
    public var context : NSManagedObjectContext!
    
    @IBOutlet var childContentView : UIView!
    
    var stores: [Store] = []
    
    // appelé uniquement la 1ere fois
    //ajouter les stores dans la carte
    lazy var mapViewController: MapViewController = {
        let mapViewController = MapViewController()
        mapViewController.storeProvider = self
        return mapViewController
    }()
    
    //ajouter les stores dans la liste
    lazy var storeListController: StoreListViewController = {
        let storeListViewController = StoreListViewController()
        storeListViewController.storeProvider = self
        return storeListViewController
    }()
    
    
    public var visibleViewController : UIViewController {
        if mapViewController.view.window != nil {
            return mapViewController
        }
        return storeListController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //ajout dans de la map view controller dans le main store
        self.addChildViewController(mapViewController, in: childContentView)

        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEdit))
        //self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        stores = CoreDataHandler.fetchStore()!
    }
    @objc func actionEdit() {
        
    }
   
    
    // le bouton sert a switcher en la map et la liste et obligatoiremetn dans le mainStore car besoin pour switcher
    @IBAction func swtichButton(_ sender: Any) {
        
        //création d'animation
        UIView.beginAnimations("flip_animation", context: nil)
        UIView.setAnimationTransition(.flipFromRight, for: self.childContentView, cache: false)
        
        UIView.setAnimationDuration(0.5)
        
        let visibleViewController = self.visibleViewController

        self.removeVisibleChildViewController(visibleViewController)
        
        if visibleViewController == self.mapViewController {
            self.addChildViewController(UINavigationController(rootViewController : storeListController), in: childContentView)
            //self.navigationItem.rightBarButtonItem?.isEnabled = true
        }else {
            self.addChildViewController(mapViewController, in: childContentView)
            //self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        UIView.commitAnimations()
    }
    
    
    @IBAction func touchNewAppleStore(){
        let appleStoreViewController = NewAppleStoreViewController()
        //pour faire le back gravee a la navigation controller
        
        appleStoreViewController.delegate = self
        self.present(PortraitNavigationController(rootViewController : appleStoreViewController) , animated: true)
    }
    
    
}

//récupérer le delegate du NewAppleStoreViewController
extension MainStoreViewController : NewAppleStoreViewControllerDelegate {
    
    func newAppleStoreViewController(_ newAppleStoreViewController: NewAppleStoreViewController, didCreateStore store: Store) {
        print("\(store)")
        //cacher le dismiss du controller
        let data =  CoreDataHandler.fetchStore()! as [Store]
       
        self.stores = data
        newAppleStoreViewController.dismiss(animated: true)
    }
        
}


