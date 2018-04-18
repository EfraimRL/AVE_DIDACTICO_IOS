//
//  Menu_DocumentoTableViewCell.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 16/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Menu_DocumentoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgTipoDoc: UIImageView!
    @IBOutlet weak var lblDocumento: UILabel!
    @IBOutlet weak var lblReferences: UILabel!
    @IBOutlet weak var lblLinks: UILabel!
    var id = 0
    func LlenarCelda(nombre:String,id:Int,reference:String,link:String) -> Void {
        imgTipoDoc.contentMode = UIViewContentMode.scaleToFill
        lblDocumento.text = nombre
        self.id = id
        lblReferences.text = reference
        lblLinks.text = link
        imgTipoDoc.image = UIImage(named: "Books2")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
