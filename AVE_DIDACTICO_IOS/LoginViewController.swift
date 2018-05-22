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
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var scrVw: UIScrollView!
   
    @IBOutlet var viewCompleta: UIView!
    @objc func singleTapGestureCaptured(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        viewCompleta.frame.size.width = screenSize.width
        let touch = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureCaptured(gesture:)))
        scrVw.addGestureRecognizer(touch)
    }
    override func viewDidAppear(_ animated: Bool) {
        txtContrasena.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        scrVw.endEditing(true)
        view2.endEditing(true)
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
        alerta(titulo:"Campos vacions",mensaje:"No deje los campos vacios",cantidad_Botones:1,estilo_controller:.alert,estilo_boton:.default, sender: self)
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
                    alerta(titulo:"Mensaje",mensaje:json["message"].string!,cantidad_Botones:1,estilo_controller:.alert,estilo_boton:.default, sender: self)
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
                    if json["rol"] == "t"{maestro = true}
                    else{maestro = false}
                    self.performSegue(withIdentifier: "segLogAMenu", sender: nil)
                }
            }
            else{
                alerta(titulo: "Error", mensaje: "No hubo resultados del servidor\n\nNo hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self)
                print("No hay respuesta del servidor")
            }
            //alerta(titulo: "-", mensaje: "No hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self)
        }
    }
}
