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
var precioColumnasConstante:[Double] = []
var precioFilasConstante:[Double] = []

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
    precioFilasConstante = precioFilas
    precioColumnasConstante = precioColumnas
    nuevoPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
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
        let pasox = Paso(filas: cantFilas, columnas: cantColumnas)
        precioColumnas.append((totalDemandas-totalOfertas))
        precioColumnasConstante = precioColumnas
        //Agrega la columna
        for x in 0 ..< cantFilas{
            arrMatriz[x].append(Celda())
        }
        //Añade el paso a la lista de pasos
        
        let arMa = arrMatriz
        
        pasox.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
        pasox.setComentario(comentario: "La suma de las demandas es mayor, por lo que se agrega una columna")
        pasox.setCeldasValores(matrizValores: arMa)
        pasos.append(pasox)
        
    }
    else if totalOfertas > totalDemandas{
        cantFilas = cantFilas + 1
        let paso = Paso(filas: cantFilas, columnas: cantColumnas)
        precioFilas.append((totalOfertas-totalDemandas))
        precioFilasConstante = precioFilas
        //Agrega el renglon
        var nuevaFila:[Celda] = []
        for _ in 0 ..< cantColumnas{
            nuevaFila.append(Celda())
        }
        arrMatriz.append(nuevaFila)
        //Añade el paso a la lista de pasos
        
        let arMa = arrMatriz
        
        paso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
        paso.setComentario(comentario: "La suma de las ofertas es mayor, por lo que se agrega un renglon")
        paso.setCeldasValores(matrizValores: arMa)
        pasos.append(paso)
    }
    else{
        let paso2 = nuevoPaso
        paso2.comentario = "La suma de las demandas y la suma de las ofertas es igual, no se hace ajuste"
        pasos.append(paso2)
    }
    //Asignacion
    for y in 0..<cantColumnas{
      
            //print("[\(y),n]")
            while precioColumnas[y] > 0.0{
                let indexx = buscarMenorCosto(columna: y)
                //print("n = \(indexx)")
                if -1 == indexx{
                    //Error
                }
                else{
                    //print("if \(precioColumnas[y]) > \(precioFilas[indexx])")
                    if precioColumnas[y] > precioFilas[indexx]{
                        //Asignacion true
                        arrMatriz[indexx][y].valor = precioFilas[indexx]
                        arrMatriz[indexx][y].asignado = true
                        //print("precioColumnas(\(precioColumnas[y])) = \(precioColumnas[y]) - \(precioFilas[indexx])")
                        precioColumnas[y] = precioColumnas[y] - precioFilas[indexx]
                        precioFilas[indexx] = 0
                    }
                    else{
                        arrMatriz[indexx][y].valor = precioColumnas[y]
                        arrMatriz[indexx][y].asignado = true
                        //print("precioFilas(\(precioFilas[indexx])) = \(precioColumnas[y]) - \(precioFilas[indexx])")
                        precioFilas[indexx] = precioFilas[indexx]-precioColumnas[y]
                        precioColumnas[y] = 0
                    }
                    //Guarda paso de asignacion
                    let paso = Paso(filas: cantFilas, columnas: cantColumnas)
                    let pFil = precioFilas
                    let pCol = precioColumnas
                    let arMa = arrMatriz
                    
                    paso.setOfertaYDemanda(ofertas: pCol, demandas: pFil)
                    paso.setComentario(comentario: "Paso de asignacion")
                    paso.setCeldasValores(matrizValores: arMa)
                    pasos.append(paso)
                }
                
            }
        
    }
    if true {
        let pFil = precioFilas
        let pCol = precioColumnas
        let arMa = arrMatriz
        let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
        newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
        newPaso.setComentario(comentario: "Asignacion terminada")
        newPaso.setCeldasValores(matrizValores: arMa)
        pasos.append(newPaso)
    }
	
    //Validacion de asignacion "#R + #C - 1 = Asignaciones"
    var arrCeldas:[(Int,Int)] = []
    var celdasAsignadas = 0
    var x = 0
    var y = 0
    for row in arrMatriz{
    	for celda in row{
            if celda.asignado {
                celdasAsignadas = celdasAsignadas + 1
                print("celda:[\(x),\(y)], \(pasos.last?.NombresFilas[x]), \(pasos.last?.NombresColumnas[y+1])")
                arrCeldas.append((x,y))
            }
            y = y + 1
        }
        x = x + 1
        y = 0
    }
    var RN:[Double] = []
    var CN:[Double] = []
    for _ in 0 ..< cantColumnas {RN.append(-999)}
    for _ in 0 ..< cantFilas {CN.append(-999)}
    
	//Si son iguales continia con el procedimiento
    print("\(cantFilas) + \(cantColumnas) - 1 = \(celdasAsignadas)")
    if ((cantFilas + cantColumnas) - 1) == celdasAsignadas{
        //Primero se busca cual columna o renglon tiene mas celdas asignadas, para suponer el valor de este como 0; y hacer el despeje de los demas valores
        let primerAsignacion = cualAsignar0()
        
        //Si es un Renglon el que tiene mayor cantidad de celdas asignadas, se supone como 0
        if primerAsignacion.1 == 1{
            RN[primerAsignacion.0] = 0
            //Se despeja cada C del renglon R(primeraAsignacion.0)
            var index = 0
            for i in arrMatriz[primerAsignacion.0]{
                if i.asignado{
                    CN[index] = DespejarX(n: RN[primerAsignacion.0], costo: i.costo)
                }
                index = index + 1
            }
            for i in 0 ..< RN.count{
                if RN[i] == -999{
                    var index2 = 0
                    for j in arrMatriz[i]{
                        if RN[i] != -999{break}
                        if j.asignado && CN[index2] != -999{
                            RN[i] = DespejarX(n: CN[index2], costo: j.costo)
                            break
                        }
                        index2 = index2 + 1
                    }
                }
            }
            for i in RN{
                print("R\(i)")
            }
            for i in CN{
                print("C\(i)")
            }
        }//Si no, debe ser una columna. Se supone su valor como 0
        else if primerAsignacion.1 == 0{
            CN[primerAsignacion.0] = 0
            
        }
        /*for x in arrCeldas{
            if RN[x.0] == -1 && CN[x.1] == -1{
                RN[x.0] = 0
            }
            let resultado = Despejar(rn: RN[x.0], cn: CN[x.1], costo: arrMatriz[x.0][x.1].costo)
            
        }*/
    }
    
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
func Despejar(rn:Double,cn:Double,costo:Double) -> (Double,Int){
    return (0.0,0)
}
func DespejarX(n:Double,costo:Double) -> Double{
    return -(n+costo)
}

//Devuelve (posicion, si es R devuelve 1 y si es C devuelve 0)
func cualAsignar0() -> (Int,Int){
    var posicion = -1
    var valor:Int = 0
    var tipo = 1
    //Primero busca en renglones el que tenga mas valores asignados
    var contador = 0
    for x in 0 ..< arrMatriz.count {
        for y in 0 ..< arrMatriz[x].count{
            if arrMatriz[x][y].asignado{
                contador = contador + 1
            }
        }
        if contador > valor{
            valor = contador
            posicion = x
        }
        contador = 0
    }
    //Segundo se busca la columna que tenga mas valores asignados
    contador = 0
    for y in 0 ..< arrMatriz[0].count {
        for x in 0 ..< arrMatriz.count{
            if arrMatriz[x][y].asignado{
                contador = contador + 1
            }
        }
        if contador > valor{
            valor = contador
            posicion = y
            tipo = 0
        }
        contador = 0
    }
    return (posicion,tipo)
}
func buscarMenorCosto(columna:Int) -> Int{
    print("Precio de la columna\(precioColumnas[columna])")
    var returnIndex = -1
    var menorCosto = Double.greatestFiniteMagnitude
    var index = 0
    for renglon in arrMatriz {
        print("if M \(renglon[columna].costo) < \(menorCosto) && \(precioFilas[index]>0) ")
        if (renglon[columna].costo < menorCosto) && (precioFilas[index]>0){
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
