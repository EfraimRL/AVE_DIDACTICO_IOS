//
//  RegistroViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {

    @IBOutlet weak var imgFotoPerfil: UIImageView!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtNumControl: UITextField!
    @IBOutlet weak var txtNombreDeMaestro: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContrasena1: UITextField!
    @IBOutlet weak var txtContrasena2: UITextField!
    @IBOutlet weak var swTipoUsuario: UISwitch! //Selecciona en caso de ser maestro o alumno
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swTipoUsuario.setOn(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnRegistrar(_ sender: Any) {
        if Registro() {
            performSegue(withIdentifier: "segRegAMenu", sender: nil)
        }
        else{
            //Alert
        }
    }
    
    func Registro() -> Bool{
        if campoVacioOIncorrecto(){
            return false
        }
        else{
            //Hace la consulta, si se hace el registro devuelve true para mandar al menu
            return true
        }
    }
    func campoVacioOIncorrecto() -> Bool {
        if txtNombre.text == "" || txtCorreo.text == "" || txtContrasena1.text == "" || txtContrasena2.text == "" || txtNumControl.text == "" {
            print("Campos vacios")
            return true
        }
        return true
    }
}
