//
//  Met_IteracionDePasosViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit
class Met_IteracionDePasosViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
//Declaracion de variables
    var arrMostrarValaorActual: [Double] = []
    var arrMostrarCostoActual: [Double] = []
    
    @IBAction func btnDescripcion(_ sender: Any) {
        
        alerta(titulo:"Descripcion", mensaje:lblDescripcion.text!, cantidad_Botones:1, estilo_controller:.alert, estilo_boton:.default, sender: self)
    }
    @IBOutlet weak var lblDescripcion: UILabel!
    //Metodos y botones simples
    @IBOutlet weak var cvIteracionDePasos: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cvIteracionDePasos.delegate = self
        cvIteracionDePasos.dataSource = self
        lblDescripcion.text = pasos[iteracionActual].comentario
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//Llenado del collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        step = []
        pasos[iteracionActual].reiniciarDatos()
        for i in 0 ..< (pasos[iteracionActual].filas + 2) * (pasos[iteracionActual].columnas + 2){
            let dupla = pasos[iteracionActual].getCelda(indice: i)
            step.append(dupla)
        }
        return (pasos[iteracionActual].filas + 2) * (pasos[iteracionActual].columnas + 2)
    }
    var step:[(Any,Int)] = []
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIteracion", for: indexPath) as! Met_IteracionDePasosCollectionViewCell
        let dupla = step[indexPath.row]
        //print(dupla.1)
        if dupla.1 == 0{
            cell.lblValor.text = (dupla.0 as! String)
            if (Double(dupla.0 as! String) == nil){
                cell.lblValor.backgroundColor = #colorLiteral(red: 0.2254115045, green: 0.7712759376, blue: 0.6908344626, alpha: 1)
                cell.lblValor.adjustsFontSizeToFitWidth = true
            }
            else{
                cell.lblValor.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            cell.lblPrecio.text = ""
        }
        else if dupla.1 == 1{
            let paso = dupla.0 as! Celda
            cell.lblPrecio.text = "\(paso.costo)"
            if paso.asignado{
                cell.lblValor.text = "\(paso.valor)"
            }
            else{
                cell.lblValor.text = ""
            }
            if paso.color == 0{
                cell.lblValor.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            if paso.signo == 1{
                cell.lblValor.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            if paso.signo == -1{
                cell.lblValor.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            cell.lblPrecio.tintColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        }
        /*
        cell.lblValor.text = "\(listaPasos[iteracionActual][indexPath.row])"
        cell.lblPrecio.text = "\(arrCostos[indexPath.row])"
        */
        return cell
    }
//Tamaño de las celdas: largo, ancho, espacio...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height - 100
        let cellwidth:CGFloat = screenWidth / CGFloat(pasos[iteracionActual].columnas + 2)
        let cellHieght:CGFloat = screenHeight / CGFloat(pasos[iteracionActual].filas + 2)
        /*if ((pasos[iteracionActual].columnas + 2) > 7) || ((pasos[iteracionActual].filas + 2) > 7){
            let cellwidth1:CGFloat = screenWidth / CGFloat(5)
            let cellHieght1:CGFloat = screenHeight / CGFloat(5)
            return CGSize(width: cellwidth1, height: cellHieght1)
        }
        */
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
//Botones, funcion principal
    //Siguiente paso
    @IBAction func btnSiguiente(_ sender: Any) {
        //Asigna el elemento siguiente de la lista de pasos (Siguiene paso), a los arreglos 'arrMostrarValorActual' y 'arrMostrarCostoActual'
        if iteracionActual < (pasos.count - 1){
            iteracionActual = iteracionActual + 1
            lblDescripcion.text = pasos[iteracionActual].comentario
            cvIteracionDePasos.reloadData()
        }
        //Recarga el Collection view
    }
    //Al resultado final
    @IBAction func btnFinal(_ sender: Any) {
        //Asigna el ultimo elemento de la lista de pasos (Ultimo paso) a los arreglos 'arrMostrarValorActual' y 'arrMostrarCostoActual'
        iteracionActual = (pasos.count) - 1
        lblDescripcion.text = pasos[iteracionActual].comentario
        cvIteracionDePasos.reloadData()
        //Recarga el Collection view
    }
    //Anterior paso
    @IBAction func btnAnterior(_ sender: Any) {
        //Asigna el elemento anterior de la lista de pasos (Paso anterior) a los arregos 'arrMostrarValorActual' y 'arrMostrarCostoActual'
        if iteracionActual > 0{
            iteracionActual = iteracionActual - 1
            lblDescripcion.text = pasos[iteracionActual].comentario
            cvIteracionDePasos.reloadData()
        }
        //Recarga el Collection view
    }
}
