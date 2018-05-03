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
    
    @IBOutlet weak var txtPregunta: UILabel!
    var pregunta_Id:Int = -1
    var pregunta = Pregunta()
    var respuestas:[Respuesta] = []
    @IBOutlet weak var btn1Img: UIButton!
    @IBOutlet weak var btn2Img: UIButton!
    @IBOutlet weak var btn3Img: UIButton!
    @IBOutlet weak var btn4Img: UIButton!
    var b1 = true
    var b2 = false
    var b3 = false
    var b4 = false
    @IBOutlet weak var lblAns1: UILabel!
    @IBOutlet weak var lblAns2: UILabel!
    @IBOutlet weak var lblAns3: UILabel!
    @IBOutlet weak var lblAns4: UILabel!
    
    @IBAction func btn1(_ sender: Any) {
        btn1Img.setImage(UIImage(named: "rdbCh"), for: .normal)
        btn2Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn3Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn4Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        
        b1 = true
        b2 = false
        b3 = false
        b4 = false
    }
    @IBAction func btn2(_ sender: Any) {
        btn1Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn2Img.setImage(UIImage(named: "rdbCh"), for: .normal)
        btn3Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn4Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        b1 = false
        b2 = true
        b3 = false
        b4 = false
    }
    @IBAction func btn3(_ sender: Any) {
        btn1Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn2Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn3Img.setImage(UIImage(named: "rdbCh"), for: .normal)
        btn4Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        b1 = false
        b2 = false
        b3 = true
        b4 = false
    }
    @IBAction func btn4(_ sender: Any) {
        btn1Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn2Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn3Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn4Img.setImage(UIImage(named: "rdbCh"), for: .normal)
        b1 = false
        b2 = false
        b3 = false
        b4 = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btn1Img.setImage(UIImage(named: "rdbCh"), for: .normal)
        btn2Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn3Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        btn4Img.setImage(UIImage(named: "rdbUn"), for: .normal)
        
        b1 = true
        b2 = false
        b3 = false
        b4 = false
        // Initialization code
    }

    func getCheched() -> Int {
        if b1 {
            return 1
        }
        else if b2 {
            return 2
        }
        else if b3 {
            return 3
        }
        else if b4 {
            return 4
        }
        else{
            return -1
        }
    }

    func llenarPreguntaYRespuestas(pregunta: Pregunta, respuestas:[Respuesta]){
        self.pregunta = pregunta
        self.respuestas = respuestas
        txtPregunta.text = pregunta.id
        
        lblAns1.text = respuestas[0].description
        lblAns2.text = respuestas[1].description
        lblAns3.text = respuestas[2].description
        lblAns4.text = respuestas[3].description
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
