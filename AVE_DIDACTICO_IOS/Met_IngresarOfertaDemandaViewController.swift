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
    var tablaDemandas:[UITableViewCell] = []
    var collectionOfertas:[UICollectionViewCell] = []
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//Demandas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tablaDemandas = []
        for _ in 0 ..< cantFilas{
            tablaDemandas.append(UITableViewCell())
        }
        print("Cantidad de filas: \(cantFilas)")
        return cantFilas
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDemanda", for: indexPath) as! Met_IngresarDemandasTableViewCell
        cell.lblNombre?.text = "Fila \(indexPath.row + 1)"
        //cell.txt?.placeholder = "Ingrese el valor de la posiciòn [\(indexPath.row + 1), \(indexllenadoDeValores + 1)]"
        tablaDemandas[indexPath.row] = cell
        print("tablas: \(tablaDemandas.count), actual \(indexPath.row)")
        return cell
    }
    //Funciones y diseño de la Tabla
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
//Ofertas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionOfertas = []
        for _ in 0 ..< cantColumnas{
            collectionOfertas.append(UICollectionViewCell())
        }
        
        print("Cantidad de columnas: \(cantColumnas)")
        return cantColumnas
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOferta", for: indexPath) as! Met_IngresarOfertasCollectionViewCell
        cell.lblNombre.text = "Columna \(indexPath.row + 1)"
        collectionOfertas[indexPath.row] = cell
        print("Collection: \(collectionOfertas.count), actual \(indexPath.row)")
        return cell
    }
    //Funciones y diseño de la coleccion
    
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
        do {
            
            let itemCount = collectionOfertas.count
            for row in 0 ..< itemCount {
                if let cell = collectionOfertas[row] as? Met_IngresarOfertasCollectionViewCell{
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
                print("Row collectionOfertas \(row)")
            }
            
            let rowCount = tablaDemandas.count
            for row in 0 ..< rowCount {
                if let cell = tablaDemandas[row] as? Met_IngresarDemandasTableViewCell{
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
                print("row tablaDemandas \(row)")
            }
            if correcto && cantFilas == filas.count && cantColumnas == columnas.count{
                precioFilas = filas
                precioColumnas = columnas
                performSegue(withIdentifier: "segIngreOfertasDemandas-A-IngreColumnas", sender: nil)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    @IBAction func btnSiguienteTextBox(_ sender: Any) {
        var asignada = true
        let itemCount = collectionOfertas.count
        let rowCount = tablaDemandas.count
        
        if asignada{
            for row in 1 ..< rowCount {
                let cell = tablaDemandas[row] as! Met_IngresarDemandasTableViewCell
                
                if cell.txt.isFirstResponder {
                    let cell1 = tablaDemandas[row] as! Met_IngresarDemandasTableViewCell
                    cell1.txt.becomeFirstResponder()
                    asignada = false
                    break
                }
            }
        }
        
        
        if asignada{
            for row in 1 ..< itemCount {
                let cell = collectionOfertas[row-1] as! Met_IngresarOfertasCollectionViewCell
                if cell.txt.isFirstResponder{
                    let cell1 = collectionOfertas[row] as! Met_IngresarOfertasCollectionViewCell
                    cell1.txt.becomeFirstResponder()
                    asignada = false
                    break
                }
            }
            
        }
        
        if asignada {
            let cell = tablaDemandas[rowCount-1] as! Met_IngresarDemandasTableViewCell
            
            if cell.txt.isFirstResponder{
                let cell = collectionOfertas[0] as! Met_IngresarOfertasCollectionViewCell
                cell.txt.becomeFirstResponder()
                asignada = false
            }
        }
        if asignada {
            let cell = tablaDemandas[0] as! Met_IngresarDemandasTableViewCell
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
