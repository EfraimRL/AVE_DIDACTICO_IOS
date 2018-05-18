//
//  RegistroViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegistroViewController: UIViewController {
    @IBOutlet weak var scrVw: UIView!
    
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
    @IBOutlet var viewCompleta: UIView!
    @objc func singleTapGestureCaptured(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        viewCompleta.frame.size.width = screenSize.width
        swTipoUsuario.setOn(false, animated: false)
        let touch = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureCaptured(gesture:)))
        scrVw.addGestureRecognizer(touch)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    @IBAction func btnRegistrar(_ sender: Any) {
        print("Registro")
        Registro()
    }
    
    func Registro(){
        if campoVacioOIncorrecto(){
            
        }
        else{
            let usuario = setUsuario()
            registrarUsuario(usuario: usuario)
            
        }
    }
    func setUsuario() -> Usuario{
        let user = Usuario()
        
        user.email = txtCorreo.text!
        user.password = txtContrasena1.text!
        user.password_confirmation = txtContrasena2.text!
        user.name = txtNombre.text!
        user.names = txtNombre.text!
        user.lastnames = txtApellido.text!
        user.carrer = txtNombreDeMaestro.text!
        user.grade = txtEdad.text!
        user.control_number = txtNumControl.text!
        if swTipoUsuario.isOn{
            user.rol = "teacher"
        }
        else{
            user.rol = "student"
        }
        return user
    }
    func campoVacioOIncorrecto() -> Bool {
        if (txtNombre.text?.isEmpty)! || (txtCorreo.text?.isEmpty)! || (txtContrasena1.text?.isEmpty)! || (txtContrasena2.text?.isEmpty)! || (txtNumControl.text?.isEmpty)! {
            alerta(titulo: "Advertencia", mensaje: "No deje campos vacios", cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
            print("Campos vacios")
            return true
        }
        return false
    }
    func unWind(){
        self.performSegue(withIdentifier: "unWindTo_LogInSegue", sender: nil)
    }
    func registrarUsuario(usuario:Usuario){
        let dataSend = ["user":[ "email":usuario.email, "password": usuario.password,"password_confirmation":usuario.password_confirmation,"names":usuario.names,"lastnames":usuario.lastnames,"name":usuario.name,"control_number":usuario.control_number,"carrer":usuario.carrer,"grade":usuario.grade,"algorithm_level":usuario.algorithm_level,"course_level":usuario.course_level,"rol":usuario.rol]] as [String:Any]
        print(dataSend)
        Alamofire.request("\(localhost)/users.json",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            print(response)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"].stringValue
                    alerta(titulo: "No se pudo hacer el registro", mensaje: result, cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
                    print("Nulo: ",result)
                }
                else{
                    if json["errors"].exists(){
                        let doct = json["errors"].dictionaryValue
                        let json2 = json["errors"]
                        var message = ""
                        for ele in doct{
                            message = message + "\n\n" + "\(ele.key): \(json2[ele.key][0].description)"
                        }
                        alerta(titulo: "Error en el registro", mensaje: message, cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
                    }
                    if json["id"].exists(){
                        alerta(titulo: "Exito", mensaje: "Registro realizado satisfactoriamente", cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
                        
                    }
                }
            }
            else{
                alerta(titulo: "Error", mensaje: "No hubo resultados del servidor o no hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self,i:1)
                print("No hay respuesta del Web Service")
            }
        }
    }
}
