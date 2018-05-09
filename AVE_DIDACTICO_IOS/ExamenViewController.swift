//
//  ExamenViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 11/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ExamenViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var cantQuestions = 0
    var quizz_id = -1
    var questions:[Pregunta] = []
    var question_options:[[Respuesta]] = []
    var cells:[UITableViewCell] = []
    

    @IBOutlet weak var tvExamenes: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        tvExamenes.dataSource = self
        tvExamenes.delegate = self
        TraerPreguntas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells = []
        for _ in 0 ..< cantQuestions{
            cells.append(UITableViewCell())
        }
        return cantQuestions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellExamenPregunta", for: indexPath) as! ExamenPreguntaTableViewCell
        print("questions = \(questions.count),questions_options = \(question_options.count)")
        if questions.count != question_options.count{
            tableView.reloadData()
        }
        else{
        cell.llenarPreguntaYRespuestas(pregunta: questions[indexPath.row],respuestas: question_options[indexPath.row])
        cells[indexPath.row] = cell
        }
        return cell
    }
    func TraerPreguntas(){
        questions = []
        question_options = []
        //devuelve todas las preguntas del quiz = quizz_id y manda a llamar el metodo de las respuestas
        getPreguntas(quiz_id:quizz_id)
        
        /*
        questions = [(1,"Pregunta 1..?"),(2,"Pregunta 2..?"),(3,"Pregunta 3..?")]
        question_optdions = [
            [(0,"Si"), (1,"No"), (0,"Quiza"), (0,"No se")],
            [(0,"Si"), (1,"No"), (0,"Quiza"), (0,"No se")],
            [(0,"Si"), (1,"No"), (0,"Quiza"), (0,"No se")],
            [(0,"Si"), (1,"No"), (0,"Quiza"), (0,"No se")]
        ]
        */
    }
    @IBAction func RevisarExamen(_ sender: Any) {
        
        revisar()
    }
    func revisar(){
        var suma = 0
        if timerRunning{
            timer.invalidate()
            timerRunning = false
        }
        let rowCount = tvExamenes.numberOfRows(inSection: 0)
        let sectionCount = tvExamenes.numberOfSections
        print("sections \(sectionCount)")
        //Ciclo para leer cada cuadro de texto de la tabla
        print("RowCount:\(rowCount)")
        
        
        for cc in cells{
            let cell1 = cc as! ExamenPreguntaTableViewCell
            suma = suma + cell1.getCheched()
        }
        alerta(titulo: "Terminado", mensaje: "Calificaciòn: \(suma)", cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self,i:1)
        
    }
    func unWind(){
        performSegue(withIdentifier: "unWindTo_ExamenesListWithSegue", sender: nil)
    }
    /////////
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var timerRunning = false
    func runTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ExamenViewController.contador)), userInfo: nil, repeats: true)
    }
    @objc func contador(){
        print("\(timer.timeInterval)")
        if seconds == 10 {
            timer.invalidate()
            revisar()
        }
        seconds = seconds + 1
    }
    //////////
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //var quest:[Pregunta] = []
    func getPreguntas(quiz_id:Int){//Page es un enumerator -> [Pregunta]
        Alamofire.request("\(localhost)/preguntas/\(quiz_id).json", headers: user_headers).responseJSON{ response in
            if response.result.value != nil {
                
                var listaElementos:[Pregunta] = []
                
                let json = JSON(response.result.value!)
                if json == JSON.null {
                    let result = json["message"]
                    
                    alerta(titulo:"Informaciòn",mensaje:json["message"].stringValue,cantidad_Botones:1,estilo_controller:.alert,estilo_boton:.default, sender: self)
                    print(result)
                }
                else{
                    if let jsonArray = json.array
                    {
                        //it is an array, each array contains a dictionary
                        for item in jsonArray
                        {
                            if let jsonDict = item.dictionary //jsonDict : [String : JSON]?
                            {
                                let question:Pregunta = Pregunta()
                                
                                question.id = (jsonDict["id"]?.intValue)!
                                question.description = (jsonDict["description"]?.stringValue)!
                                
                                listaElementos.append(question)
                                
                            }
                        }
                    }
                }
                self.questions = listaElementos
                self.cantQuestions = self.questions.count
                
                //Por cada pregunta agregara un arreglo de 4 respuestas al arreglo de question_options
                for x in self.questions{
                    let _ = self.getRespuestas(question_id:x.id)
                }
            }
        }
        //return listaElementos
    }
    //var quest_options:[[Respuesta]] = []
    func getRespuestas(question_id:Int) {//Page es un enumerator -> [Respuesta]
        
        Alamofire.request("\(localhost)/respuestas/\(question_id).json", headers: user_headers).responseJSON{ response in
            if response.result.value != nil {
                
                let json = JSON(response.result.value!)
                if json == JSON.null {
                    let result = json["message"]
                alerta(titulo:"Informaciòn",mensaje:json["message"].stringValue,cantidad_Botones:1,estilo_controller:.alert,estilo_boton:.default, sender: self)
                    print(result)
                }
                else{
                    if let jsonArray = json.array
                    {
                        var listaElemento:[Respuesta] = []
                        //it is an array, each array contains a dictionary
                        for item in jsonArray
                        {
                            if let jsonDict = item.dictionary //jsonDict : [String : JSON]?
                            {
                                let question_option:Respuesta = Respuesta()
                                
                                question_option.id = (jsonDict["id"]?.intValue)!
                                question_option.description = (jsonDict["description"]?.stringValue)!
                                question_option.value = (jsonDict["value"]?.intValue)!
                                
                                listaElemento.append(question_option)
                            }
                        }
                        
                        self.question_options.append(listaElemento)
                        //Cuando acaba actualiza la tabla
                        if self.questions.count == self.question_options.count{
                            self.tvExamenes.reloadData()
                        }
                    }
                }
            }
        }
        //quest_options.append(listaElementos)
        //return listaElementos
    }
}
