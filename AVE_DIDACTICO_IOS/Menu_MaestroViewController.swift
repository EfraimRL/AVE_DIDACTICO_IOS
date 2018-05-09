//
//  Menu_MaestroViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 22/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Menu_MaestroViewController: UIViewController {
    @IBOutlet weak var lblAlumnos: UILabel!
    @IBOutlet weak var lblPromedio: UILabel!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var viewContenedora: UIView!
    @IBOutlet weak var viewContenida: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarDatos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cargarDatos(){
        Alamofire.request("\(localhost)/buscarPromedio/\(user_id).json", headers: user_headers).responseJSON{ response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"]
                    print(result)
                    alerta(titulo:"Informaciòn", mensaje:json["message"].stringValue, cantidad_Botones:1, estilo_controller:.alert, estilo_boton:.default, sender: self)
                }
                else{
                    let str = json[0]["description"].stringValue
                    let ave = json[0]["average"].floatValue
                    print("\(str), \(ave)")
                    self.lblAlumnos.text = str
                    self.lblPromedio.text = "Promedio: \(ave)"
                    print("Antes: \(self.viewContenida.frame.size.height)")
                    self.viewContenida.frame.size.height = CGFloat(Float(self.viewContenedora.frame.size.height) * (ave/100))
                    print("Despues: \(self.viewContenida.frame.size.height)")
                    var color = UIColor.red
                    if ave > 70{
                        color = UIColor.green
                    }
                    self.viewContenida.backgroundColor = color
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
