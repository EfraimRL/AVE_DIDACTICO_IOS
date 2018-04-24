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
    
    @IBAction func btnContinuar(_ sender: Any) {
        if txtCantidadFilas.text == "" || txtCantidadColumnas.text == "" {
            print("Favor de ingresar la cantidad de filas y la cantidad de columnas (Fabricas y Bodegas)")
        }
        else{
            if let Filas = Int(txtCantidadFilas.text!), let Columnas = Int(txtCantidadColumnas.text!){
                reiniciarDatos()
                print("Yeah \(Filas), \(Columnas)")
                cantColumnas = Columnas
                cantFilas = Filas
                iteracionActual = 0
                definirMatriz()
                performSegue(withIdentifier: "segDefinirTamano-A-IngreOfertasDemandas", sender: nil)
            } else {
                print("Verifique que los valores sean enteros")
            }
            
            
        }
    }
    func definirMatriz(){
        var renglones:[Double] = []
        arrMatriz = []
        for _ in 0..<cantColumnas{
            renglones.append(0)
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
