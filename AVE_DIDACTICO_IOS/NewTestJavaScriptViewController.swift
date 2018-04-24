//
//  NewTestJavaScriptViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 18/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit
import JavaScriptCore
import SwiftyJSON

class NewTestJavaScriptViewController: UIViewController {

    var jsContext: JSContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeJS()
        helloWorld()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func initializeJS() {
        self.jsContext = JSContext()
        
        // Add an exception handler.
        self.jsContext.exceptionHandler = { context, exception in
            if let exc = exception {
                print("JS Exception:", exc.toString())
            }
        }
        
        // Specify the path to the jssource.js file.
        if let jsSourcePath = Bundle.main.path(forResource: "jssource", ofType: "js") {
            do {
                // Load its contents to a String variable.
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                // Add the Javascript code that currently exists in the jsSourceContents to the Javascript Runtime through the jsContext object.
                self.jsContext.evaluateScript(jsSourceContents)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func helloWorld() {
        if let variableHelloWorld = self.jsContext.objectForKeyedSubscript("jso") {
            
            let array = variableHelloWorld.toObject()
            let object = array! as! [String:AnyObject]
            print(object)
            print("Object ",array!)
            //print(jh)
            let array1 = variableHelloWorld.toString()
            print("String ",array1!)
            let str:String = array1!
            let data = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            let array2 = variableHelloWorld.toArray()
            print("Array ",array2!)
            
            let tr = array as! [Any]
            
            print(variableHelloWorld.toArray())
            
            let json = variableHelloWorld as! [String:Any]
                print(json)
            
        }
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
class objeto {
    var valor = ""
}
