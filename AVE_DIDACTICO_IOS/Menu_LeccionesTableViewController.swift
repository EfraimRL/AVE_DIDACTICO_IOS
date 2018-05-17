//
//  Menu_LeccionesTableViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class Menu_LeccionesTableViewController: UITableViewController {


    var lista:[[Any]] = []
    override func viewDidLoad() {
        runTimer()
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        var con = conexion()
        self.lista = con.listar(page: Page.Lecciones.rawValue, tipo: 1, completion: true)
        
        /*if let listar = listar(page: Page.Lecciones.rawValue,tipo: 1){
            lista = listar
        }*/
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    /////////
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(Menu_LeccionesTableViewController.nada)), userInfo: nil, repeats: true)
    }
    @objc func nada(){
        lista = lec
        self.tableView.reloadData()
        if !lista.isEmpty {
            timer.invalidate()
        }
        
    }
    //////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lista.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLeccion", for: indexPath) as! Menu_LeccionTableViewCell
        let cell_data = lista[indexPath.row]
        
        cell.LlenarCelda(id:cell_data[0] as! Int,name:cell_data[1] as! String, available:cell_data[2] as! Int, price:cell_data[3] as! Double, algorithm_id:cell_data[4] as! Int)

        return cell
    }
    //Al seleccionar una leccion se manda el id y muestra la informacion
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! Menu_LeccionTableViewCell
        if cell.available != 0 {
            performSegue(withIdentifier: "cellMenu_Lecciones-A-Leccion", sender: cell.id)
        }
        else{
            //Alert
            print("No esta disponible")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("A \(sender.debugDescription)")
        let value = sender.unsafelyUnwrapped
        if Int("\(value)") != nil{
            let destino = segue.destination as! LeccionTableViewController
            destino.session_id = sender as! Int
        }
    }
    //Salir
    @IBAction func unWindTo_LeccionesList(segue:UIStoryboardSegue!){}
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
