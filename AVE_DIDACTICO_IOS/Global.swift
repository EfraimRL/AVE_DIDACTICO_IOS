//
//  Global.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 14/03/18.
//  Copyright © 2018 EfraimRL. All rights reserved.
//

import Foundation

//Datos que se usan para crear el objeto 'Paso'
var cantColumnas:Int = 0
var cantFilas:Int = 0

var arrMatriz:[[Celda]] = []//Cambiar Double por Celda'
var arrCostos:[Double] = []  //Quitar al usar Celda'
var arrValores:[Celda] = []
    //Crear una copia auxiliar de estos dos precios
var precioColumnas:[Double] = []
var precioFilas:[Double] = []

//Para otras cosas
var iteracionActual:Int = 0

//Guarda los Pasos ....Cambiar [[Double]] por [Paso]'
var pasos:[Paso] = []
var listaPasos:[[Double]] = []


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
    /*arrValores = []
    for x in 0..<cantFilas{
        for y in 0..<cantColumnas{
            let valor :Double = arrMatriz[x][y]
            arrValores.append(valor)
        }
    }*/
}

//Llamado a los metodos de solucion
func GenerarPasos(metodo: Metodo){
    //Agrega el paso inicial
    let nuevoPaso = Paso(filas: cantFilas, columnas: cantColumnas)
    nuevoPaso.setOfertaYDemanda(ofertas: precioColumnas, demandas: precioFilas)
    nuevoPaso.setComentario(comentario: "Datos ingresados, antes de hacer ajustes")
    nuevoPaso.setCeldasValores(matrizValores: arrMatriz)
    pasos.append(nuevoPaso)
    
    //Continua con la validacion de oferta/demanda
    var totalDemandas = 0.0
    var totalOfertas = 0.0
    for x in precioColumnas {
        totalOfertas = totalOfertas + x
    }
    for y in precioFilas {
        totalDemandas = totalDemandas + y
    }
    
    if totalDemandas > totalOfertas {
        cantColumnas = cantColumnas + 1
        let paso = Paso(filas: cantFilas, columnas: cantColumnas)
        precioColumnas.append((totalDemandas-totalOfertas))
        //Agrega la columna
        for x in 0 ..< cantFilas{
            arrMatriz[x].append(Celda())
        }
        //Añade el paso a la lista de pasos
        paso.setOfertaYDemanda(ofertas: precioColumnas, demandas: precioFilas)
        paso.setComentario(comentario: "La suma de las demandas es mayor, por lo que se agrega una columna")
        paso.setCeldasValores(matrizValores: arrMatriz)
        pasos.append(paso)
        
    }
    else if totalOfertas > totalDemandas{
        cantFilas = cantFilas + 1
        let paso = Paso(filas: cantFilas, columnas: cantColumnas)
        precioFilas.append((totalOfertas-totalDemandas))
        //Agrega el renglon
        var nuevaFila:[Celda] = []
        for _ in 0 ..< cantColumnas{
            nuevaFila.append(Celda())
        }
        arrMatriz.append(nuevaFila)
        //Añade el paso a la lista de pasos
        paso.setOfertaYDemanda(ofertas: precioColumnas, demandas: precioFilas)
        paso.setComentario(comentario: "La suma de las ofertas es mayor, por lo que se agrega un renglon")
        paso.setCeldasValores(matrizValores: arrMatriz)
        pasos.append(paso)
    }
    else{
        let paso2 = nuevoPaso
        paso2.comentario = "La suma de las demandas y la suma de las ofertas es igual, no se hace ajuste"
        pasos.append(paso2)
    }
    //Asignacion
    for y in 0..<cantColumnas{
        for x in stride(from: 0, through: cantFilas, by: 1){
            while precioColumnas[y] > 0.0{
                let indexx = buscarMenorCosto(columna: y)
                if -1 == indexx{
                    //Error
                }
                else{
                    if precioColumnas[y] > precioFilas[indexx]{
                        arrMatriz[indexx][y].valor = precioFilas[indexx]
                        precioFilas[indexx] = 0
                    }
                    else{
                        arrMatriz[indexx][y].valor = precioColumnas[y]
                        precioColumnas[y] = 0
                    }
                }
                
            }
        }
    }
    let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
    newPaso.setOfertaYDemanda(ofertas: precioColumnas, demandas: precioFilas)
    newPaso.setComentario(comentario: "Asignacion")
    newPaso.setCeldasValores(matrizValores: arrMatriz)
    pasos.append(newPaso)
    
    
    /*
     var resultado:[[Double]] = []
	switch metodo {
		case .ave:
			resultado = MetodoAVE()
	}
    listaPasos = resultado
     */
    iteracionActual = 0
}
func buscarMenorCosto(columna:Int) -> Int{
    var returnIndex = -1
    var menorCosto = Double.greatestFiniteMagnitude
    var index = 0
    for renglon in arrMatriz {
        if (renglon[columna].costo < menorCosto) && (precioColumnas[columna]>0){
            menorCosto = renglon[columna].costo
            returnIndex = index
        }
        index = index + 1
    }
    return returnIndex
}
//Metodos de soluciones
    //Metodo temporal.....Cambiar por el verdadero
func MetodoAVE() -> [[Double]]{
    var arrPasos : [[Double]] = []
    for index in 1...7 {
        var arrPaso:[Double] = []
    	for x in 0..<cantFilas {
    		for y in 0..<cantColumnas {
    			//arrPaso.append(arrMatriz[x][y] + Double(index))
			}
		}
        arrPasos.append(arrPaso)
	}
    return arrPasos
}
