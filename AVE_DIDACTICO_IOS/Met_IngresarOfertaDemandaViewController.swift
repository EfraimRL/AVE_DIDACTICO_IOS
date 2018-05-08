//
//  Met_IngresarOfertaDemandaViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 24/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Met_IngresarOfertaDemandaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var tvDemandas: UITableView!
    @IBOutlet weak var cvOfertas: UICollectionView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cantFilas
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDemanda", for: indexPath) as! Met_IngresarDemandasTableViewCell
        cell.lblNombre?.text = "Fila \(indexPath.row + 1)"
        //cell.txt?.placeholder = "Ingrese el valor de la posiciòn [\(indexPath.row + 1), \(indexllenadoDeValores + 1)]"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cantColumnas
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOferta", for: indexPath) as! Met_IngresarOfertasCollectionViewCell
        cell.lblNombre.text = "Columna \(indexPath.row + 1)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = cvOfertas.cellForItem(at: IndexPath(row: indexPath.row, section: 0)) as! Met_IngresarOfertasCollectionViewCell
        cell.txt.text = "a"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tvDemandas.delegate = self
        tvDemandas.dataSource = self
        cvOfertas.delegate = self
        cvOfertas.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSiguiente(_ sender: Any) {
        var correcto = true
        var filas:[Double] = []
        var columnas:[Double] = []
        
        let itemCount = cvOfertas.numberOfItems(inSection: 0)
        for row in 0 ..< itemCount {
            let cell = cvOfertas.cellForItem(at: IndexPath(row: row, section: 0)) as! Met_IngresarOfertasCollectionViewCell
            let dob:String = cell.txt.text!
            if let doble = Double(dob){
                columnas.append(doble)
            }
            else{
                correcto = false
                cell.txt.becomeFirstResponder()
                break
            }
        }
        
        let rowCount = tvDemandas.numberOfRows(inSection: 0)
        for row in 0 ..< rowCount {
            let cell = tvDemandas.cellForRow(at: IndexPath(row: row, section: 0)) as! Met_IngresarDemandasTableViewCell
            let dob:String = cell.txt.text!
            if let doble = Double(dob){
//Inserta cantidad de demandas
                filas.append(doble)
            }
            else{
                correcto = false
                cell.txt.becomeFirstResponder()
                break
            }
        }
        if correcto {
            precioFilas = filas
            precioColumnas = columnas
            performSegue(withIdentifier: "segIngreOfertasDemandas-A-IngreColumnas", sender: nil)
        }
    }
    func balance(){
        
    }
    @IBAction func btnSiguienteTextBox(_ sender: Any) {
        var asignada = true
        let itemCount = cvOfertas.numberOfItems(inSection: 0)
        let rowCount = tvDemandas.numberOfRows(inSection: 0)
        
        if asignada{
            for row in 1 ..< rowCount {
                let cell = tvDemandas.cellForRow(at: IndexPath(row: row-1, section: 0)) as! Met_IngresarDemandasTableViewCell
                
                if cell.txt.isFirstResponder {
                    let cell1 = tvDemandas.cellForRow(at: IndexPath(row: row, section: 0)) as! Met_IngresarDemandasTableViewCell
                    cell1.txt.becomeFirstResponder()
                    asignada = false
                    break
                }
            }
        }
        
        
        if asignada{
            for row in 1 ..< itemCount {
                let cell = cvOfertas.cellForItem(at: IndexPath(row: row-1, section: 0)) as! Met_IngresarOfertasCollectionViewCell
                if cell.txt.isFirstResponder{
                    let cell1 = cvOfertas.cellForItem(at: IndexPath(row: row, section: 0)) as! Met_IngresarOfertasCollectionViewCell
                    cell1.txt.becomeFirstResponder()
                    asignada = false
                    break
                }
            }
            
        }
        
        if asignada {
            let cell = tvDemandas.cellForRow(at: IndexPath(row: rowCount-1, section: 0)) as! Met_IngresarDemandasTableViewCell
            
            if cell.txt.isFirstResponder{
                let cell = cvOfertas.cellForItem(at: IndexPath(row: 0, section: 0)) as! Met_IngresarOfertasCollectionViewCell
                cell.txt.becomeFirstResponder()
                asignada = false
            }
        }
        if asignada {
            let cell = tvDemandas.cellForRow(at: IndexPath(row: 0, section: 0)) as! Met_IngresarDemandasTableViewCell
                cell.txt.becomeFirstResponder()
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
