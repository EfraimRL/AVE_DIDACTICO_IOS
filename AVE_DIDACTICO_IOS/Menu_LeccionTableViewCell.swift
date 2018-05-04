//
//  Menu_LeccionTableViewCell.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Menu_LeccionTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var lblLeccion: UILabel!
    var id = 0
    var available:Bool = false
    var price = 0.0
    func LlenarCelda(id:Int,name:String, available:Bool, price:Double) -> Void {
        self.id = id
        lblLeccion.text = name
        self.available = available
        self.price = price
        imgLock.contentMode = UIViewContentMode.scaleToFill
        if available {
            imgLock.image = UIImage(named: "Unlock")//Use unlock image
        }
        else {
            imgLock.image = UIImage(named: "Lock")//Use lock image
        }
    }
    /*lessons
    //sessions
    "id":1,
    "name":"Leccion 1",
    "avaible":null,
    "price":0,

    "created_at":"2018-04-03T14:34:04.000Z",
    "updated_at":"2018-04-03T14:34:04.000Z",
    "url":"http://localhost:3000/sessions/1.json"
    */
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
