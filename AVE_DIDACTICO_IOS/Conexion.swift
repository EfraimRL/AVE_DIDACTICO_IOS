//
//  Conexion.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 09/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

var localhost = "http://192.168.43.59:3000/"
var user_id = 0
var user_email = "", user_token = "",user_name = "", user_last_name = ""
var user_headers: HTTPHeaders =  [String:AnyObject]() as! HTTPHeaders

//Variables para actualizar las tablas de Documentos, lecciones y examenes
var doc:[[Any]] = []
var exa:[[Any]] = []
var lec:[[Any]] = []

enum Page :String{
    case LogIn = "users/sign_in.json"
    case Lecciones = "sessions.json"
    case Examenes = "quizzes.json"
    case Documentos = "consultations.json"
}
//https://learnappdevelopment.com/uncategorized/how-to-observe-changes-in-variables-with-swift-3-and-ios-10/
var page:[String] = ["users/sign_in.json","lessons.json","tests.json"]
class conexion {
    init(){}
    func listar(page: String,tipo:Int, completion: Bool) -> [[Any]]{//Page es un enumerator
        var listaElementos:[[Any]] = []
        Alamofire.request("\(localhost)/\(page)", headers: user_headers).responseJSON{ response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                if json == JSON.null {
                    let result = json["message"]
                    print(result)
                    //Mandar mensaje de Error.
                }
                else{
                    if let jsonArray = json.array
                    {
                        //it is an array, each array contains a dictionary
                        for item in jsonArray
                        {
                            if let jsonDict = item.dictionary //jsonDict : [String : JSON]?
                            {
                                var elemento:[Any] = [0 ,"" ,false ,"" ]
                                switch tipo {
                                case 1://Lecciones
                                    elemento[0] = jsonDict["id"]?.intValue as Any
                                    elemento[1] = jsonDict["name"]?.stringValue as Any
                                    elemento[2] = jsonDict["avaible"]?.boolValue as Any
                                    elemento[3] = jsonDict["price"]?.double as Any
                                case 2://Examenes
                                    elemento[0] = jsonDict["id"]?.intValue as Any
                                    elemento[1] = jsonDict["description"]?.stringValue as Any
                                    elemento[2] = jsonDict["approved"]?.intValue as Any
                                    elemento[3] = jsonDict["avaible"]?.intValue as Any
                                case 3://Documentos
                                    elemento[0] = jsonDict["id"]?.intValue as Any
                                    elemento[1] = jsonDict["books"]?.stringValue as Any
                                    elemento[2] = jsonDict["references"]?.stringValue as Any
                                    elemento[3] = jsonDict["links"]?.stringValue as Any
                                default:
                                    print("Ningun tipo")
                                }
                                listaElementos.append(elemento)
                                print(listaElementos)
                                
                            }
                        }
                        switch tipo{
                        case 1: lec = listaElementos
                        case 2: exa = listaElementos
                        case 3: doc = listaElementos
                        default: print("Default sw")
                        }
                    }
                }
            }
            else{
                //alerta(titulo: "Error", mensaje: "No hubo resultados del servidor\n\nno hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self)
            }
        }
        
        return listaElementos
    }
}
//Trae la lista de Lecciones, Examenes y Documentos.

/*
//Books consultations.json
{
    "id":1,
    "links":"http://www.link.com",
    "books":"How to solve.",
    "references":"B.La.",
    
    "url":"http://localhost:3000/consultations/1.json"
    
    "created_at":"2018-04-03T13:13:03.000Z",
    "updated_at":"2018-04-03T13:13:03.000Z",
}
//lessons
//sessions
"id":1,
"name":"Leccion 1",
"avaible":null,
"price":0,

"created_at":"2018-04-03T14:34:04.000Z",
"updated_at":"2018-04-03T14:34:04.000Z",
"url":"http://localhost:3000/sessions/1.json"
//exams
//quizzes?
{"id":1,
    "description":"New quiz, is the number one",
    "approved":1,
    "avaible":false,
    
    "created_at":"2018-03-22T20:44:21.000Z",
    "updated_at":"2018-03-22T20:44:21.000Z",
    "url":"http://localhost:3000/quizzes/1.json"}
 */


class Pregunta{
    var id:Int = -1
    var description:String = ""
}
class Respuesta{
    var id:Int = -1
    var description:String = ""
    var value:Int = -1
}
