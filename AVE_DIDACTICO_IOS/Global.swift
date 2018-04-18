//
//  Global.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 EfraimRL. All rights reserved.
//

import Foundation

var cantColumnas:Int = 0
var cantFilas:Int = 0

var iteracionActual:Int = 0

var arrValores:[Double] = []
var arrMatriz:[[Double]] = []
var arrCostos:[Double] = []

var listaPasos:[[Double]] = []

var precioColumnas:[Double] = []
var precioFilas:[Double] = []

var maestro:Bool = false
func esMaestro() -> Bool{
    return maestro
}

var indexllenadoDeValores = 0

enum Metodo :String{
    case ave = "AVE"
}

func reiniciarDatos(){
    cantColumnas = 0
    cantFilas = 0
    iteracionActual = 0
    indexllenadoDeValores = 0
    arrValores = []
    arrMatriz = []
    arrCostos = []
    listaPasos = []
    
}

func establecerValores() {
    arrValores = []
    for x in 0..<cantFilas{
        for y in 0..<cantColumnas{
            let valor :Double = arrMatriz[x][y]
            arrValores.append(valor)
        }
    }
}

//Llamado a los metodos de solucion
func GenerarPasos(metodo: Metodo){
	var resultado:[[Double]] = []
	switch metodo {
		case .ave:
			resultado = MetodoAVE()
	}
    listaPasos = resultado
    iteracionActual = 0
}
//Metodos de soluciones
    //Metodo temporal.....Cambiar por el verdadero
func MetodoAVE() -> [[Double]]{
    var arrPasos : [[Double]] = []
    for index in 1...7 {
        var arrPaso:[Double] = []
    	for x in 0..<cantFilas {
    		for y in 0..<cantColumnas {
    			arrPaso.append(arrMatriz[x][y] + Double(index))
			}
		}
        arrPasos.append(arrPaso)
	}
    return arrPasos
}
