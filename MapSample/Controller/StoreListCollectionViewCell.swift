//
//  StoreListCollectionViewCell.swift
//  MapSample
//
//  Created by Isma Dia on 06/12/2017.
//  Copyright © 2017 Isma Dia. All rights reserved.
//

import UIKit

class StoreListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var latLabel: UILabel!
    
    @IBOutlet var lonLabel: UILabel!
    
    @IBOutlet var openingHoursLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
