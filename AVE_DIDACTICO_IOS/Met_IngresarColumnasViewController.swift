//
//  Met_IngresarColumnasViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Met_IngresarColumnasViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblTitulo: UILabel!
    

    @IBOutlet weak var tvIngresarColumna: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tvIngresarColumna.delegate = self
        tvIngresarColumna.dataSource = self
        lblTitulo.text = "Ingresar valores de la columna \(indexllenadoDeValores + 1)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSiguiente(_ sender: Any) {
    //Mientras que iteracion sea menor a cantidad de columnas
        if camposCorrectos() {
            if indexllenadoDeValores < cantColumnas {
                print("\(indexllenadoDeValores),\(cantColumnas)")
                
                //Guarda los datos
                guardar()
                //A la iteracion suma 1
                indexllenadoDeValores = indexllenadoDeValores + 1
                //Recarga la ventana
                //Si es mayor o igual
                if indexllenadoDeValores >= cantColumnas{
                    //Manda al siguiente paso
                    performSegue(withIdentifier: "segIngreColumnas-A-IngreCosto", sender: nil)
                }
                else{
                    lblTitulo.text = "Ingresar valores de la columna \(indexllenadoDeValores + 1)"
                    tvIngresarColumna.reloadData()
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cantFilas
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFila", for: indexPath) as! Met_IngresarColumnaTableViewCell
        cell.lblElemento?.text = "Fila \(indexPath.row + 1)"
        cell.txtValor?.placeholder = "Ingrese el valor de la posiciòn [\(indexPath.row + 1), \(indexllenadoDeValores + 1)]"
        cell.txtValor.text = ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func camposCorrectos() -> Bool {
        let rowCount = tvIngresarColumna.numberOfRows(inSection: 0)
        for row in 0 ..< rowCount {
            let cell = tvIngresarColumna.cellForRow(at: IndexPath(row: row, section: 0)) as! Met_IngresarColumnaTableViewCell
            print("Valor: \(cell.txtValor.text!)")
            if cell.txtValor.text == ""
            {
                print("No deje campos vacios")
                return false
            }
            else if !esDouble(valor: cell.txtValor.text!) {
                print("Verifique que todos los valores son numero")
                return false
            }
        }
        return true
    }
    func esDouble(valor: String) -> Bool{
        if let doble = Double(valor){
            return true
        }
        else{
            return false
        }
    }
    
    func guardar() -> Bool {
        let rowCount = tvIngresarColumna.numberOfRows(inSection: 0)
        //Ciclo para leer cada cuadro de texto de la tabla
        for row in 0 ..< rowCount {
            var cel = Celda()
            let cell = tvIngresarColumna.cellForRow(at: IndexPath(row: row, section: 0)) as! Met_IngresarColumnaTableViewCell
                let dob:String = cell.txtValor.text!
            cel.valor = Double(dob)!
            arrMatriz[row][indexllenadoDeValores] = cel
            //cell.txtValor.text = ""
        }
        return true
    }
}
