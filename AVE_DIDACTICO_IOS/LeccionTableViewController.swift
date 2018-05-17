//
//  LeccionTableViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 11/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeccionTableViewController: UITableViewController {

    var session_id = -1
    var txt1 = "", txt2 = "", txt3 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 2000
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        if session_id != -1{
            getLeccion(session_id: session_id)
        }
        else{
            print("No existe el ID")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
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
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLeccionDetalles", for: indexPath) as! LeccionDetalleTableViewCell
        cell.setCell(txt1: txt1, txt2: txt2, txt3: txt3)

        return cell
    }
    
    func getLeccion(session_id:Int){//Page es un enumerator -> [Pregunta]
        Alamofire.request("\(localhost)/session_details/\(session_id).json", headers: user_headers).responseJSON{ response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                if json == JSON.null {
                    let result = json["message"]
                    print(result)
                    alerta(titulo:"Informaciòn", mensaje:json["message"].stringValue, cantidad_Botones:1, estilo_controller:.alert, estilo_boton:.default, sender: self)
                }
                else{
                    self.txt1 = json["txt1"].stringValue
                    self.txt2 = "\n\(json["txt2"].stringValue)\n"
                    self.txt3 = json["txt3"].stringValue
                }
                self.tableView.reloadData()
            }
        }
    }
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
