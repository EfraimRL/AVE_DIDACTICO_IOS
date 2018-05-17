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
        lblLicencias.text = "Icons made Freepik from https://www.flaticon.com/\n Creative Commons BY 3.0 \nMatrix icon made by Stephen Hutchings from https://www.flaticon.com/ \nGraph icon made by Gregor Cresnar from https://www.flaticon.com/\nEngine icon made by Smashicons from https://www.flaticon.com/\nis licensed by CC 3.0 BY (http://creativecommons.org/licenses/by/3.0/)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GuardarNuevaDireccion(_ sender: Any) {
        localhost = txtDireccionServer.text!
    }
    
    @IBAction func DireccionDefault(_ sender: Any) {
        localhost = "http://192.168.43.59:3000/"
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
