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
//Metodos y botones simples
    @IBOutlet weak var cvIteracionDePasos: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cvIteracionDePasos.delegate = self
        cvIteracionDePasos.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//Llenado del collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cantFilas * cantColumnas
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIteracion", for: indexPath) as! Met_IteracionDePasosCollectionViewCell
        cell.lblValor.text = "\(listaPasos[iteracionActual][indexPath.row])"
        cell.lblPrecio.text = "\(arrCostos[indexPath.row])"
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
//Botones, funcion principal
    //Siguiente paso
    @IBAction func btnSiguiente(_ sender: Any) {
        //Asigna el elemento siguiente de la lista de pasos (Siguiene paso), a los arreglos 'arrMostrarValorActual' y 'arrMostrarCostoActual'
        if iteracionActual < (listaPasos.count - 1){
            iteracionActual = iteracionActual + 1
            cvIteracionDePasos.reloadData()
        }
        //Recarga el Collection view
    }
    //Al resultado final
    @IBAction func btnFinal(_ sender: Any) {
        //Asigna el ultimo elemento de la lista de pasos (Ultimo paso) a los arreglos 'arrMostrarValorActual' y 'arrMostrarCostoActual'
        iteracionActual = (listaPasos.count) - 1
        cvIteracionDePasos.reloadData()
        //Recarga el Collection view
    }
    //Anterior paso
    @IBAction func btnAnterior(_ sender: Any) {
        //Asigna el elemento anterior de la lista de pasos (Paso anterior) a los arregos 'arrMostrarValorActual' y 'arrMostrarCostoActual'
        if iteracionActual > 0{
            iteracionActual = iteracionActual - 1
            cvIteracionDePasos.reloadData()
        }
        //Recarga el Collection view
    }
}
