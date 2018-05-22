//
//  InfoViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 17/05/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var lblLicencias: UITextView!
    @IBOutlet weak var txtDireccionServer: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDireccionServer.text = "\(localhost)"
        txtMax.text = "\(maximoValor)"
        txtMin.text = "\(minimoValor)"
        lblLicencias.text = "Icons made Freepik from https://www.flaticon.com/\n Creative Commons BY 3.0 \nMatrix icon made by Stephen Hutchings from https://www.flaticon.com/ \nGraph icon made by Gregor Cresnar from https://www.flaticon.com/\nEngine icon made by Smashicons from https://www.flaticon.com/\nRefresh icon made by Pixel Buddha from www.flaticon.com\nis licensed by CC 3.0 BY (http://creativecommons.org/licenses/by/3.0/)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtMin: UITextField!
    @IBOutlet weak var txtMax: UITextField!
    @IBAction func GuardarNuevaDireccion(_ sender: Any) {
        localhost = txtDireccionServer.text!
        let min:String = txtMin.text!
        minimoValor = Int(min)!
        let max:String = txtMax.text!
        maximoValor = Int(max)!
    }
    
    @IBAction func DireccionDefault(_ sender: Any) {
        localhost = "http://192.168.43.59:3000/"
        txtDireccionServer.text = localhost
        minimoValor = 2
        maximoValor = 6
        txtMax.text = "\(maximoValor)"
        txtMin.text = "\(minimoValor)"
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
