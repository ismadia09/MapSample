//
//  NewAppleStoreViewController.swift
//  MapSample
//
//  Created by Isma Dia on 15/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

//custome delegate pour garder le store créer pour pouvoir l'utiliser partout
public protocol NewAppleStoreViewControllerDelegate : class {
    
     func newAppleStoreViewController(_
        newAppleStoreViewController: NewAppleStoreViewController, didCreateStore store: Store)
}

public class NewAppleStoreViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var latTextField: UITextField!
    
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var lonTextField: UITextField!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hoursTextField: UITextField!
    
    public var context : NSManagedObjectContext!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var latView: UIView!
    @IBOutlet weak var lonView: UIView!
    @IBOutlet weak var hoursView: UIView!
    
    var store: Store?
    var isForUpdate = false
    
    
    //Lorsqu'on 
    public weak var delegate: NewAppleStoreViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        //titre de la vue
        self.title = NSLocalizedString("controller.new_apple_store.title", comment: "")
        self.titleLabel.text = NSLocalizedString("controller.new_apple_store.title_label", comment: "")
         self.latLabel.text = NSLocalizedString("controller.new_apple_store.latitude_label", comment: "")
         self.lonLabel.text = NSLocalizedString("controller.new_apple_store.longitude_label", comment: "")
        self.hoursLabel.text = NSLocalizedString("controller.new_apple_store.opening_hours_label", comment: "")
        
        self.titleTextField.delegate = self
        self.latTextField.delegate = self
        self.lonTextField.delegate = self
        self.hoursTextField.delegate = self
        
        nameView.layer.cornerRadius = 5
        latView.layer.cornerRadius = 5
        lonView.layer.cornerRadius = 5
        hoursView.layer.cornerRadius = 5
        
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.darkGray
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        
        if isForUpdate == false {
            
        //création du bouton annuler
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeViewController))
            
        //création du bouton valider
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(submitAppleStore))
            
        }else {
            
        //création du bouton modififer
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(submitAppleStore))
            
            let lat = store?.latitude
            let lon = store?.longitude
            
            titleTextField.text = store?.name
            latTextField.text = lat?.toString()
            lonTextField.text = lon?.toString()
            hoursTextField.text = store?.openingHours
        
        }
        
    }
    
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    @objc public func closeViewController(){
        isForUpdate = false
        self.dismiss(animated: true)
    }
    
    @objc public func submitAppleStore(){
        
        guard let title = titleTextField.text, title.count > 0,
        let latString = latTextField.text,
        let lat = Double(latString),
        let lonString = lonTextField.text,
        let lon = Double(lonString),
        let hours = hoursTextField.text else {
            //creation d'alerte
           let alert = UIAlertController(title: NSLocalizedString("app.vocabulary.error_title", comment: ""),
                                         message: NSLocalizedString("app.vocabulary.error_form_message", comment: "") , preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.close", comment: ""), style: .cancel))
            
            //presentation de l'alerte
            present(alert, animated: true)
            
                return
        }
        
        if isForUpdate == false {
        
        let store = CoreDataHandler.createStore(name: title, latitude: lat, longitude: lon, openingHours: hours)
        
        //on met le store dans le delegate, on le notifie mais personne ecout pour l'instant, il faut le faire dans le view controller de la map
        self.delegate?.newAppleStoreViewController(self, didCreateStore: store)
        }else {
            
            guard let storeToModify = store else {
                return
            }
            CoreDataHandler.updateSpecificStore(storeToModify, name: title, latitude: lat, longitude: lon, openingHours: hours)
            navigationController?.popViewController(animated: true)
        }
        
    }

}

extension NewAppleStoreViewController : UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
