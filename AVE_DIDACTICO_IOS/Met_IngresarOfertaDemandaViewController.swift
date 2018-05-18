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
    var valoresX:[Double] = []
    var valoresY:[Double] = []
    var indeX = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var txtExtra: UILabel!
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
        cell.txt.text = "\(valoresX[indexPath.row])"
        if valoresX[indexPath.row] == -999.9 {
            cell.txt.text = ""
        }
        print("tablas: \(tablaDemandas.count), actual \(indexPath.row)")
        return cell
    }
    //Funciones y diseño de la Tabla
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indeX = indexPath.row
        lblElementoActual.text = "Demanda \(indeX + 1)"
        txtValor.text = "\(valoresX[indeX])"
        if valoresX[indeX] == -999.9 {
            txtValor.text = ""
        }
        btnSalirIngresarValor.alpha = 1
        viewIngresarValor_X.constant = 0
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
        cell.txt.text = "\(valoresY[indexPath.row])"
        if valoresY[indexPath.row] == -999.9 {
            cell.txt.text = ""
        }
        print("Collection: \(collectionOfertas.count), actual \(indexPath.row)")
        return cell
    }
    //Funciones y diseño de la coleccion
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indeX = indexPath.row
        lblElementoActual.text = "Oferta \(indeX + 1)"
        txtValor.text = "\(valoresX[indeX])"
        if valoresX[indeX] == -999.9 {
            txtValor.text = ""
        }
        btnSalirIngresarValor.alpha = 1
        viewIngresarValor_X.constant = 0
        
    }
    @IBAction func SuigienteDato(_ sender: Any) {
        var doble = -999.9
        if Double(txtValor.text!) != nil{
            doble = Double(txtValor.text!)!
        }
        
        if indeX < cantFilas{
            valoresX[indeX] = doble
            
        }
        else{
            valoresY[indeX - cantFilas] = doble
        }
        if indeX == (cantFilas + cantColumnas - 1) {
            indeX = 0
            
        }
        else{
            indeX = indeX + 1
            
        }
        //Siguiente
        
        if indeX < cantFilas{
            txtValor.text =  "\(valoresX[indeX])"
            if valoresX[indeX] == -999.9{
                txtValor.text = ""
            }
            lblElementoActual.text = "Demanda \(indeX + 1)"
        }
        else{
            lblElementoActual.text = "Oferta \(indeX - cantFilas + 1)"
            txtValor.text = "\(valoresY[indeX - cantFilas])"
            if valoresY[indeX - cantFilas] == -999.9{
                txtValor.text = ""
            }
        }
    }
    @IBOutlet weak var txtValor: UITextField!
    @IBAction func SalirIngrsarValor(_ sender: Any) {
        btnSalirIngresarValor.alpha = 0
        viewIngresarValor_X.constant = viewIngresarValor_X.constant - CGFloat(300)
        var doble = -999.9
        if Double(txtValor.text!) != nil{
            doble = Double(txtValor.text!)!
        }
        if indeX < cantFilas{
            valoresX[indeX] = doble
            
        }
        else{
            valoresY[indeX - cantFilas] = doble
        }
        tvDemandas.reloadData()
        cvOfertas.reloadData()
        self.view.endEditing(true)
    }
    @IBOutlet weak var lblElementoActual: UILabel!
    @IBOutlet weak var btnSalirIngresarValor: UIButton!
    @IBOutlet weak var viewIngresarValor: UIView!
    @IBOutlet weak var viewIngresarValor_X: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        tvDemandas.delegate = self
        tvDemandas.dataSource = self
        cvOfertas.delegate = self
        cvOfertas.dataSource = self
        btnSalirIngresarValor.alpha = 0
        viewIngresarValor_X.constant = viewIngresarValor_X.constant - CGFloat(300)
        for _ in 0 ..< cantFilas{
            valoresX.append(-999.9)
        }
        for _ in 0 ..< cantColumnas{
            valoresY.append(-999.9)
        }
        txtExtra.text = "# Demandas (Filas): \(cantFilas)\n\n# Ofertas (Columnas): \(cantColumnas)"
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
                if valoresY[row] != -999.9{
                    columnas.append(valoresY[row])
                }
                else{
                    correcto = false
                    break
                }
                
                print("Row collectionOfertas \(row)")
            }
            
            let rowCount = tablaDemandas.count
            for row in 0 ..< rowCount {
                if valoresX[row] != -999.9{
                    filas.append(valoresX[row])
                }
                else{
                    correcto = false
                    break
                }
                print("row tablaDemandas \(row)")
            }
            if correcto && cantFilas == filas.count && cantColumnas == columnas.count{
                precioFilas = filas
                precioColumnas = columnas
                performSegue(withIdentifier: "segIngreOfertasDemandas-A-IngreColumnas", sender: nil)
            }
            else{
                alerta(titulo: "Información", mensaje: "Faltan campos por llenar", cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
            }
        } catch {
            print(error.localizedDescription)
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
