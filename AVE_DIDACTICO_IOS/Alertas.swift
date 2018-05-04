//
//  Alertas.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 11/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import Foundation
import UIKit

func alerta(titulo:String,mensaje:String,cantidad_Botones:Int,estilo_controller:UIAlertControllerStyle,estilo_boton:UIAlertActionStyle, sender: UIViewController) {
    // create the alert
    let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: estilo_controller)
    
    // add an action (button)
    alert.addAction(UIAlertAction(title: "OK", style: estilo_boton, handler: nil))
    if cantidad_Botones == 1 {
        
    }
    else {
        alert.addAction(UIAlertAction(title: "Cancelar", style: estilo_boton, handler: nil))
    }
    // show the alert
    sender.present(alert, animated: true, completion: nil)
}
