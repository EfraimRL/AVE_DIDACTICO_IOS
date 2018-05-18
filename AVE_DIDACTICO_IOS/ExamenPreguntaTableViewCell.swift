//
//  ExamenPreguntaTableViewCell.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 11/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import UIKit

class ExamenPreguntaTableViewCell: UITableViewCell {

    var correctAnswer = 0
    
    @IBOutlet weak var viewPregunta: UIView!
    @IBOutlet weak var txtPregunta: UILabel!
    var pregunta_Id:Int = -1
    var pregunta = Pregunta()
    var respuestas:[Respuesta] = []
    
    var botones:[UIButton] = []
    var botonesChecked:[Bool] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenSize = UIScreen.main.bounds
        viewPregunta.frame.size.width = screenSize.width-2
        
    }

    func getCheched() -> Int {
        print("cantidad de botones: \(botones.count)")
        for x2 in 0 ..< botones.count{
            if botonesChecked[x2]{
                print("\(pregunta.description):\(respuestas[x2].value)")
                return respuestas[x2].value
            }
        }
        print("\(pregunta.description):No contestada")
        return 0
    }

    func llenarPreguntaYRespuestas(pregunta: Pregunta, respuestas:[Respuesta]){
        self.pregunta = pregunta
        txtPregunta.text = pregunta.description
        self.respuestas = respuestas
        ClearAll()
        for y in 0 ..< respuestas.count{
            createButtons(indice: y, texto: respuestas[y].description)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func ClearAll(){
        botonesChecked = []
        botones = []
        
    }
    func createButtons(indice: Int, texto: String){
        let newButton = UIButton()
        newButton.setImage(UIImage(named: "rdbUn"), for: .normal)
        newButton.frame = CGRect(x:15,y:(70*(indice+1)),width:40,height:40)
        newButton.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
        
        let newButtonChecked = false
        botones.append(newButton)
        botonesChecked.append(newButtonChecked)
        
        let newLabel = UILabel()
        newLabel.frame = CGRect(x:63,y:(60+(70*indice)),width:253,height:66)
        newLabel.text = texto
        addSubview(newButton)
        addSubview(newLabel)
        
    }
    @objc func buttonClicked(sender: UIButton){
        for i in 0 ..< botones.count{
            if sender == botones[i]{
                botones[i].setImage(UIImage(named: "rdbCh"), for: .normal)
                botonesChecked[i] = true
            }
            else{
                botones[i].setImage(UIImage(named: "rdbUn"), for: .normal)
                botonesChecked[i] = false
            }
        }
    }
}
