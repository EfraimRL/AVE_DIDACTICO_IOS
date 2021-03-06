//
//  LoginViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        txtContrasena.text = ""
    }
    
    @IBAction func btnLogIn(_ sender: Any) {
        let email:String = txtUsuario.text!
        let password:String = txtContrasena.text!
        if !email.isEmpty && !password.isEmpty {
            let userInfo = ["session":["email":email, "password":password]] as [String:Any]
            print(userInfo)
            Log_in(dataSend: userInfo)
        }
        else{
            print("No deje campos vacios")
        }
    }
    
    @IBAction func btnRegistrarse(_ sender: Any) {
        performSegue(withIdentifier: "segRegistrarse", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    @IBAction func unWindTo_LogIn(segue:UIStoryboardSegue!){}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func Log_in(dataSend: [String:Any]){
        user_id = -1
        Alamofire.request("\(localhost)/users/sign_in.json",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            print(response)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json["message"].exists() {
                    print("Nulo: ",json["message"].string!)
                }	
                else{
                    
                    user_id = json["id"].int!
                    user_email = json["email"].string!
                    user_token = json["authentication_token"].stringValue
                    user_name = json["name"].string!
                    user_last_name = json["last_name"].string!
                    
                    user_headers = [
                        "X-User-Email":user_email,
                        "Content-Type":"application/json",
                        "X-User-Token":user_token]
                    if json["rol"] == "student"{maestro = false}
                    else if json["rol"] == "teacher"{maestro = true}
                    self.performSegue(withIdentifier: "segLogAMenu", sender: nil)
                }
            }
            else{
                //alerta(titulo: "Error", mensaje: "No hubo resultados del servidor\n\nno hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self)
                print("No hay respuesta del servidor")
            }
            //alerta(titulo: "-", mensaje: "No hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self)
        }
    }
}
