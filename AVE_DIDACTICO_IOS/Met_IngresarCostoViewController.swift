//
//  Met_IngresarCostoViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Met_IngresarCostoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//Declaracion de variables
    //txtCosto es usado para llenar el valor del costo en cada celda, cuando se le da tap
    @IBOutlet weak var txtCosto: UITextField!
    //index permite saber que celda fue la seleccionada
    var index:IndexPath? = nil
    
    @IBOutlet weak var cvIngresarCostos: UICollectionView!
//Metodos y botones con funciones simples..Inicializadores, botones de continuar, etc.
    override func viewDidLoad() {
        establecerValores()
        super.viewDidLoad()
        cvIngresarCostos.delegate = self
        cvIngresarCostos.dataSource = self
        posX.constant = -600
        arrValores = []
        for x in 0..<cantFilas{
            for y in 0..<cantColumnas{
                arrValores.append(arrMatriz[x][y])
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnContinuar(_ sender: Any) {
        arrCostos = []
        for iter in 0..<(cantFilas*cantColumnas){
            let cell = cvIngresarCostos.cellForItem(at: IndexPath(row: iter, section: 0)) as! Met_IngresarCostoCollectionViewCell
            let dob:String = cell.lblCosto.text!
            if (Double(dob) != nil){
                arrCostos.append(Double(dob)!)
            }
            else{
                arrCostos.append(0)
            }
            
        }
        var inde = 0
        for x in 0..<cantFilas{
            for y in 0..<cantColumnas{
                arrMatriz[x][y].costo = arrCostos[inde]
                inde = inde + 1
            }
        }
        GenerarPasos(metodo: .ave)
        performSegue(withIdentifier: "segIngreCosto-A-Iteracion", sender: nil)
    }
    
    
//Llenado de collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cantFilas * cantColumnas
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIngresarCosto", for: indexPath) as! Met_IngresarCostoCollectionViewCell
        
        cell.lblValor.text = "\(arrValores[indexPath.row].valor)"
        cell.lblCosto.text = "\(indexPath.section)"
        cell.frame.size.height = cvIngresarCostos.contentSize.height/CGFloat(cantFilas)
        cell.frame.size.width = cvIngresarCostos.contentSize.width/CGFloat(cantColumnas)
        print("View \(view.frame.size.height)x\(view.frame.size.width)")
        return cell
    }
//Tamaño de las celdas: largo, ancho, espacio...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let cellwidth:CGFloat = screenWidth / CGFloat(cantColumnas)
        let cellHieght:CGFloat = screenWidth / CGFloat(cantFilas)
        print("Aqui esta el tamaño")
        return CGSize(width: cellwidth, height: cellHieght)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0.0,right: 0.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
//Posicionamiento del Modal de costo para llenado de cada celda
    @IBOutlet weak var posX: NSLayoutConstraint!
    @IBOutlet weak var btnSalirPopUP: UIButton!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath
        posX.constant = 0
        btnSalirPopUP.alpha = 0.5
    }
    @IBAction func btnSalirPopUp(_ sender: Any) {
        btnSalirPopUP.alpha = 0
        posX.constant = -600
        let cell = cvIngresarCostos.cellForItem(at: index!) as! Met_IngresarCostoCollectionViewCell
        cell.lblCosto.text = txtCosto.text
        print("\(String(describing: index))")
        txtCosto.text = ""
    }
    
}
