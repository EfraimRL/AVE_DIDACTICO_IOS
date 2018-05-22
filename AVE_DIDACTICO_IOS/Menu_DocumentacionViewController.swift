//
//  Menu_DocumentacionViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Menu_DocumentacionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tvDocumentos: UITableView!
    var lista:[[Any]] = [] {
        didSet {    //called when skinType changes
            print("changed")
            tvDocumentos.reloadData()
        }
    }
    override func viewDidLoad() {
        runTimer()
        btnRefresh.alpha = 1
        super.viewDidLoad()
        tvDocumentos.delegate = self
        tvDocumentos.dataSource = self
        let con = conexion()
        DispatchQueue.global(qos: .userInitiated).async {
            self.lista = con.listar(page: Page.Documentos.rawValue, tipo: 3, completion: true)
            
        }
        
        /*if let listar = listar(page: Page.Documentos.rawValue,tipo: 3){
            lista = listar
        }*/
    }
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(Menu_DocumentacionViewController.nada)), userInfo: nil, repeats: true)
    }
    @objc func nada(){
        lista = doc
        tvDocumentos.reloadData()
        if !lista.isEmpty {
            btnRefresh.alpha = 0
            timer.invalidate()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cellDocumento", for: indexPath) as! Menu_DocumentoTableViewCell
        let cell_data = lista[indexPath.row]
        
        cell.LlenarCelda(nombre: cell_data[1] as! String, id: cell_data[0] as! Int, reference: cell_data[2] as! String, link: cell_data[3] as! String, sessionID: cell_data[4] as! Int)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 191
    }
    @IBAction func btnActualizar(_ sender: Any) {
        Refresh()
    }
    @IBAction func Actualizar(_ sender: Any) {
        Refresh()
    }
    func Refresh(){
        btnRefresh.alpha = 1
        runTimer()
        let con = conexion()
        self.lista = con.listar(page: Page.Documentos.rawValue, tipo: 3, completion: true)
    }
    @IBOutlet weak var btnRefresh: UIButton!
    @IBAction func btnRefreshing(_ sender: Any) {
        Refresh()
    }
}
