//
//  TabBarController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 22/03/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var controllersAlumno:[UIViewController] = []
    var controllersMaestro:[UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if self.viewControllers?.count == 5 {
            controllersMaestro = self.viewControllers!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if false {
            let maestroViewController = Menu_MaestroViewController()
            maestroViewController.tabBarItem = UITabBarItem(title: "Informe", image: UIImage(), tag: 4)
            self.viewControllers?.append(maestroViewController)
        }
        if !esMaestro() && self.viewControllers?.count == 5{
            self.viewControllers?.removeLast()
        }
        else{
            if esMaestro(){
                self.viewControllers = controllersMaestro
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
