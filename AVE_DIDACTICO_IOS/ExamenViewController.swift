//
//  ExamenViewController.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 11/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class ExamenViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var cantQuestions = 5
    var quizz_id = -1
    var questions:[(Int,String)] = []
    var question_options:[[(Int,String)]] = []
    
    

    @IBOutlet weak var tvExamenes: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("quizz id = \(quizz_id)")
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
        return cantQuestions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellExamenPregunta", for: indexPath) as! ExamenPreguntaTableViewCell
        
        cell.llenarPreguntaYRespuestas(pregunta: questions[indexPath.row],respuestas: question_options[indexPath.row])
        
        return cell
    }
    func TraerPreguntas(){
        
        questions = [(1,"Pregunta 1..?"),(2,"Pregunta 2..?"),(3,"Pregunta 3..?")]
        question_options = [
            [(0,"Si"), (1,"No"), (0,"Quiza"), (0,"No se")],
            [(0,"Si"), (1,"No"), (0,"Quiza"), (0,"No se")],
            [(0,"Si"), (1,"No"), (0,"Quiza"), (0,"No se")],
            [(0,"Si"), (1,"No"), (0,"Quiza"), (0,"No se")]
        ]
        
        cantQuestions = questions.count
    }
    @IBAction func RevisarExamen(_ sender: Any) {
        
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
