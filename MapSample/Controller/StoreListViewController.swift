//
//  StoreListViewController.swift
//  MapSample
//
//  Created by Isma Dia on 16/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import UIKit

class StoreListViewController: UIViewController {
    
    
    @IBOutlet var storeTableView : UITableView!
    
    weak var storeProvider: StoreProvider?
    
    
    
    let cellId = "storeListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.delegate = self
        storeTableView.dataSource = self
    
        
        let nibCell = UINib(nibName: "StoreListTableViewCell", bundle: nil)
        storeTableView.register(nibCell, forCellReuseIdentifier: cellId)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEdit))
    }
    
    @objc func actionEdit() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storeTableView.reloadData()
    }
    
    

}


extension StoreListViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeProvider?.stores.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storeTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StoreListTableViewCell
        
        guard let store = storeProvider?.stores[indexPath.row] else {
            fatalError("Not possible")
        }
        cell.titleLabel.text = store.name
        cell.latLabel.text = String(store.latitude)
        cell.lonLabel.text = String(store.longitude)
        cell.openingHoursLabel.text = store.openingHours
        
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0
        return cell
    }
   

}

extension StoreListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.storeTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            CoreDataHandler.deleteSpecificStore(id: indexPath.row)
            storeProvider?.stores.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    
}


