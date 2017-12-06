//
//  StoreListViewController.swift
//  MapSample
//
//  Created by Isma Dia on 16/11/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import UIKit

class StoreListViewController: UIViewController {
    
    @IBOutlet var storeCollectionView : UICollectionView!
    
    
    
    let cellId = "storeListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        storeCollectionView.delegate = self
        storeCollectionView.dataSource = self
        
        let nibCell = UINib(nibName: "StoreListCollectionViewCell", bundle: nil)
        storeCollectionView.register(nibCell, forCellWithReuseIdentifier: cellId)

        // Do any additional setup after loading the view.
    }

}


extension StoreListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = storeCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoreListCollectionViewCell
        
        return cell
    }
    
    
}

extension StoreListViewController : UICollectionViewDelegateFlowLayout{
    
    //taille de l'element de la collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            width -= layout.minimumLineSpacing
        }
        return CGSize(width: width, height: width/2)
    }
    
}
