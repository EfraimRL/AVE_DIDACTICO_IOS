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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cantColumnas
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOferta", for: indexPath) as! Met_IngresarOfertasCollectionViewCell
        cell.lblNombre.text = "Columna \(indexPath.row + 1)"
        return cell
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
        let rowCount = tvDemandas.numberOfRows(inSection: 0)
        for row in 0 ..< rowCount {
            let cell = tvDemandas.cellForRow(at: IndexPath(row: row, section: 0)) as! Met_IngresarDemandasTableViewCell
            let dob:String = cell.txt.text!
            if let doble = Double(dob){
                //Guardar doble en el arreglo
            }
            else{
                correcto = false
                break
            }
        }
        let itemCount = cvOfertas.numberOfItems(inSection: 0)
        for row in 0 ..< itemCount {
            let cell = cvOfertas.cellForItem(at: IndexPath(row: row, section: 0)) as! Met_IngresarOfertasCollectionViewCell
            let dob:String = cell.txt.text!
            if let doble = Double(dob){
                //Guardar doble en el arreglo
            }
            else{
                correcto = false
                break
            }
        }
        if correcto {
            
            performSegue(withIdentifier: "segIngreOfertasDemandas-A-IngreColumnas", sender: nil)
        }
    }
    func balance(){
        
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
