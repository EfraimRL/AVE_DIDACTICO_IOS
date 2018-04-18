//
//  Met_IngresarCostoCollectionViewCell.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Met_IngresarCostoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCosto: UILabel!
    @IBOutlet weak var lblValor: UILabel!
    @IBOutlet weak var vwFondoCell: UIView!
    var x = 0
    var y = 0
    
    func setSize(heigt:CGFloat, width:CGFloat){
        vwFondoCell.frame.size.width = width
        vwFondoCell.frame.size.width = heigt
    }
}
