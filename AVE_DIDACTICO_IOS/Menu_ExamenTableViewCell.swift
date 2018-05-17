//
//  Menu_ExamenTableViewCell.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Menu_ExamenTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    var id:Int = 0
    var descripcion = ""
    var approved = 0
    var available = 0
    var session_id:Int = 0
    func LlenarCelda(id:Int,descripcion:String, approved:Int, available:Int, sessionID:Int) -> Void {
        self.id = id
        lblNombre.text = descripcion
        self.approved = approved
        self.available = available
        if available == 1 {
            imgLock.image = UIImage(named: "Unlock")//Use unlock image
        }
        else {
            imgLock.image = UIImage(named: "Lock")//Use lock image
        }
        self.session_id = sessionID
        
    }
/*exams
    //quizzes?
    {"id":1,
    "description":"New quiz, is the number one",
    "approved":1,
    "avaible":false,

    "created_at":"2018-03-22T20:44:21.000Z",
    "updated_at":"2018-03-22T20:44:21.000Z",
    "url":"http://localhost:3000/quizzes/1.json"}
    override func awakeFromNib() {
        super.awakeFromNib()
    }
*/
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
