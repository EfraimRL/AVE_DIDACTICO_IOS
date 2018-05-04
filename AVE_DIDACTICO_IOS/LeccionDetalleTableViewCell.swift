//
//  LeccionDetalleTableViewCell.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 04/05/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class LeccionDetalleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblSubtitulo: UILabel!
    @IBOutlet weak var lblInformacion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(txt1:String,txt2:String,txt3:String){
        lblTitulo.text = txt1
        lblSubtitulo.text = txt2
        lblInformacion.text = txt3
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
