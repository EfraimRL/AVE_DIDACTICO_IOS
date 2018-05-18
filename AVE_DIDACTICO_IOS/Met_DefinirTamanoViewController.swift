//
//  Met_DefinirTamanoViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Met_DefinirTamanoViewController: UIViewController {

    @IBOutlet weak var txtCantidadFilas: UITextField!
    @IBOutlet weak var txtCantidadColumnas: UITextField!
    @IBOutlet weak var swTipoMaxMin: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        reiniciarDatos()
        txtCantidadColumnas.text = ""
        txtCantidadFilas.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func btnContinuar(_ sender: Any) {
        if swTipoMaxMin.isOn{
            maximizar = false
        }
        else{
            maximizar = true
        }
        
        if txtCantidadFilas.text == "" || txtCantidadColumnas.text == "" {
            alerta(titulo:"Infromacion",mensaje:"Favor de ingresar la cantidad de filas y la cantidad de columnas (Fabricas y Bodegas)",cantidad_Botones:1,estilo_controller:.alert,estilo_boton:.default, sender: self)
            print("Favor de ingresar la cantidad de filas y la cantidad de columnas (Fabricas y Bodegas)")
        }
        else{
            if let Filas = Int(txtCantidadFilas.text!), let Columnas = Int(txtCantidadColumnas.text!){
                if Filas >= minimoValor && Filas <= maximoValor && Columnas >= minimoValor && Columnas <= maximoValor{
                        reiniciarDatos()
                        //print("Yeah \(Filas), \(Columnas)")
                        cantColumnas = Columnas
                        cantFilas = Filas
                        iteracionActual = 0
                        definirMatriz()
                        performSegue(withIdentifier: "segDefinirTamano-A-IngreOfertasDemandas", sender: nil)
                }
                else{
                    alerta(titulo:"Alerta",mensaje:"El tamaño de la tabla está fuera de los limites.\nProcure que sea entre 2 y 6 para una mejor visualizacion\n\nSi desea cambiar los limites vaya a la pantalla de inicio de sesión, en la parte superior derecha hay un boton para cambiar la confguración.\n\nEsto no garantiza el funcionamiento.",cantidad_Botones:1,estilo_controller:.alert,estilo_boton:.default, sender: self)
                    print("Verifique que los valores sean enteros")
                }
            } else {
                alerta(titulo:"Informacion",mensaje:"Verifique que los valores sean numeros enteros",cantidad_Botones:1,estilo_controller:.alert,estilo_boton:.default, sender: self)
                print("Verifique que los valores sean enteros")
            }
            
            
        }
    }
    func definirMatriz(){
        var renglones:[Celda] = []
        arrMatriz = []
        for _ in 0..<cantColumnas{
            renglones.append(Celda())
        }
        for _ in 0..<cantFilas{
            arrMatriz.append(renglones)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender == nil
        {
            var destino =  segue.destination as! Met_IngresarOfertaDemandaViewController
        }
        
    }
    //Elimina las vistas anteriores y vuelve a esta vista del menu.
    @IBAction func unwindTo_MenuMetodo(segue:UIStoryboardSegue!) {
    }
}
