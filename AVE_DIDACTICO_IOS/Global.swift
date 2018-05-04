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
    pasos = []
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
    if true{
        let nuevoPaso = Paso(filas: cantFilas, columnas: cantColumnas)
        precioFilasConstante = precioFilas
        precioColumnasConstante = precioColumnas
        nuevoPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
        nuevoPaso.setComentario(comentario: "Datos ingresados, antes de hacer ajustes")
        nuevoPaso.setCeldasValores(matrizValores: arrMatriz)
        pasos.append(nuevoPaso)
    }
    
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
        let paso2 = Paso(filas: cantFilas, columnas: cantColumnas)
        paso2.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
        paso2.setComentario(comentario: "No se hace ajuste debido a que son iguales los totales de ofertas y de las demandas (\(paso2.final)).")
        paso2.setCeldasValores(matrizValores: arrMatriz)
        pasos.append(paso2)
    }
    //Asignacion
    for y in 0..<cantColumnas{
      
        var comentario = ""
            //print("[\(y),n]")
            while precioColumnas[y] > 0.0{
                let indexx = buscarMenorCosto(columna: y)
                let cl:String = (pasos.last?.NombresColumnas[y+1])!
                let fl:String = (pasos.last?.NombresFilas[indexx])!
                
                comentario = comentario + "Como la oferta de la columna \(cl) es mayor a 0"
                //print("n = \(indexx)")
                if -1 == indexx{
                    //Error
                }
                else{
                    
                    //print("if \(precioColumnas[y]) > \(precioFilas[indexx])")
                    if precioColumnas[y] > precioFilas[indexx]{
                        comentario = comentario + " y este es mayor al de la demanda \(fl), se asigna el de la demanda a la celda [\(fl),\(cl)]"
                        //Asignacion true
                        arrMatriz[indexx][y].valor = precioFilas[indexx]
                        arrMatriz[indexx][y].asignado = true
                        //print("precioColumnas(\(precioColumnas[y])) = \(precioColumnas[y]) - \(precioFilas[indexx])")
                        precioColumnas[y] = precioColumnas[y] - precioFilas[indexx]
                        precioFilas[indexx] = 0
                    }
                    else{
                        comentario = comentario + " y este es menor o igual al de la demanda \(fl), se asigna el valor de la oferta a la celda [\(fl),\(cl)]"
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
                    paso.setComentario(comentario: comentario)
                    paso.setCeldasValores(matrizValores: arMa)
                    pasos.append(paso)
                    
                    if precioColumnas[y] > 0 {
                        comentario = "Aun queda oferta por lo que se busca el siguiente renglon con demanda mayor a 0 y costo menor.\n"
                    }
                    else{comentario = ""}
                }
                
            }
        
    }
    if true {
        let arMa = arrMatriz
        let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
        newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
        newPaso.setComentario(comentario: "Asignacion terminada. Se prosigue a verificar las asignaciones ´#R + #C - 1 = Celdas asignadas´")
        newPaso.setCeldasValores(matrizValores: arMa)
        pasos.append(newPaso)
    }
	
//Validacion de asignacion "#R + #C - 1 = Asignaciones"
    var arrCeldas:[(Int,Int)] = []
    var celdasAsignadas = 0
    var x = 0
    var y = 0
    //Busca cada celda asignada
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
    
	//Si son iguales continua con el procedimiento
    print("\(cantFilas) + \(cantColumnas) - 1 = \(celdasAsignadas)")
    //Agrega la tabla antes para validar la comparacion
    if true {
        let arMa = arrMatriz
        let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
        newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
        newPaso.setComentario(comentario: "´#R + #C - 1 = Celdas asignadas´\n\(cantFilas) + \(cantColumnas) - 1 = \(celdasAsignadas)")
        newPaso.setCeldasValores(matrizValores: arMa)
        pasos.append(newPaso)
    }
    
//Si la cantidad de celdas asignadas es igual a la de `R + C -1`
    if ((cantFilas + cantColumnas) - 1) == celdasAsignadas{
//Aqui busca los valores de cada nombre de columna o fila, para buscar un numero negativo
        var comentario:String = "Para la optimizaciòn, se busca el renglon(R#) o columna(C#) con mayor asignaciones, y se le da el valor de 0.\n"
        //Primero se busca cual columna o renglon tiene mas celdas asignadas, para suponer el valor de este como 0; y hacer el despeje de los demas valores
        let primerAsignacion = cualAsignar0()
        
        //Si es un Renglon el que tiene mayor cantidad de celdas asignadas, se supone como 0
        if primerAsignacion.1 == 1{
            RN[primerAsignacion.0] = 0
            comentario = comentario + "R\(primerAsignacion.0+1) = 0\n"
            //Se despeja cada C del renglon R(primeraAsignacion.0)
            var index = 0
            for i in arrMatriz[primerAsignacion.0]{
                if i.asignado{
                    CN[index] = DespejarX(n: RN[primerAsignacion.0], costo: i.costo)
                    comentario = comentario + "C\(index+1) se Obtiene despejando: R\(primerAsignacion.0+1) + C\(index+1) + \(i.costo) = 0. Resultado = \(CN[index])\n"
                }
                index = index + 1
            }
            //Prueba while
            var aux = false//Verifica que no quede alguno sin despejar
            
            repeat {
                //Despeja las R# que pueda
                for i in 0 ..< RN.count{
                    if RN[i] == -999{
                        var index2 = 0
                        for j in arrMatriz[i]{
                            if RN[i] != -999{break}
                            if j.asignado && CN[index2] != -999{
                                RN[i] = DespejarX(n: CN[index2], costo: j.costo)
                                comentario = comentario + "R\(i+1) se Obtiene despejando: R\(i+1) + C\(index2+1) + \(j.costo) = 0. Resultado = \(RN[i])\n"
                                break
                            }
                            index2 = index2 + 1
                        }
                    }
                }
                //Despeja las C# que pueda
                for i in 0 ..< CN.count{
                    if CN[i] == -999{
                        for j in 0 ..< arrMatriz.count{
                            if CN[i] != -999{break}
                            if arrMatriz[j][i].asignado && RN[j] != -999{
                                CN[i] = DespejarX(n: RN[j], costo: arrMatriz[j][i].costo)
                                comentario = comentario + "C\(i+1) se Obtiene despejando: R\(j+1) + C\(i+1) + \(arrMatriz[j][i].costo) = 0. Resultado = \(CN[i])\n"
                                break
                            }
                        }
                    }
                }
                    //Validacion
                for x in RN{
                        if x == -999{
                            aux = true
                        }
                }
                for x in CN{
                        if x == -999{
                            aux = true
                        }
                }
            }while(aux)
            //Termina prueba while
            //Imprime resultados
            for i in RN{
                print("R\(i)")
            }
            for i in CN{
                print("C\(i)")
            }
            //Guarda paso en la lista de pasos
            if true {
                let arMa = arrMatriz
                let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
                newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
                newPaso.setComentario(comentario: comentario)
                newPaso.setCeldasValores(matrizValores: arMa)
                pasos.append(newPaso)
            }
            //Verificar que no quede algun numero negativo
            print(comentario)
        }
        //Si no, debe ser una columna. Se supone su valor como 0
        else if primerAsignacion.1 == 0{
            CN[primerAsignacion.0] = 0
            comentario = comentario + "C\(primerAsignacion.0+1) = \(CN[primerAsignacion.0])\n"
            //Se despeja cada R de la columna C(primeraAsignacion.0)
            for i in 0 ..< arrMatriz.count{
                if arrMatriz[i][primerAsignacion.0].asignado{
                    RN[i] = DespejarX(n: CN[primerAsignacion.0], costo: arrMatriz[i][primerAsignacion.0].costo)
                    comentario = comentario + "R\(i+1) se Obtiene despejando: R\(i+1) + C\(primerAsignacion.0+1) + \(arrMatriz[i][primerAsignacion.0].costo) = 0. Resultado = \(RN[i])\n"
                }
            }
            //Prueba while
            var aux = false
            repeat {
                //Despeja las C# que pueda
                for i in 0 ..< CN.count{
                    if CN[i] == -999{
                        for j in 0 ..< arrMatriz.count{
                            if CN[i] != -999{break}
                            if arrMatriz[j][i].asignado && RN[j] != -999{
                                CN[i] = DespejarX(n: RN[j], costo: arrMatriz[j][i].costo)
                                comentario = comentario + "C\(i+1) se Obtiene despejando: R\(j+1) + C\(i+1) + \(arrMatriz[j][i].costo) = 0. Resultado = \(CN[i])\n"
                                break
                            }
                        }
                    }
                }
                //Despeja las R# que pueda
                for i in 0 ..< RN.count{
                    if RN[i] == -999{
                        var index2 = 0
                        for j in arrMatriz[i]{
                            if RN[i] != -999{break}
                            if j.asignado && CN[index2] != -999{
                                RN[i] = DespejarX(n: CN[index2], costo: j.costo)
                                comentario = comentario + "R\(i+1) se Obtiene despejando: R\(i+1) + C\(index2+1) + \(j.costo) = 0. Resultado = \(RN[i])\n"
                                break
                            }
                            index2 = index2 + 1
                        }
                    }
                }
                //Validacion
                for x in RN{
                    if x == -999{
                        aux = true
                    }
                }
                for x in CN{
                    if x == -999{
                        aux = true
                    }
                }
            }while(aux)
            //Imprime resultados
            for i in RN{
                print("R\(i)")
            }
            for i in CN{
                print("C\(i)")
            }
            print(comentario)
            //Guarda el paso en la lista de pasos
            if true {
                let arMa = arrMatriz
                let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
                newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
                newPaso.setComentario(comentario: comentario)
                newPaso.setCeldasValores(matrizValores: arMa)
                pasos.append(newPaso)
            }
        }
//Realizar ajuste en caso de ser algun numero negativo (ej R1 = -1)
        
            /*for x in arrCeldas{
            if RN[x.0] == -1 && CN[x.1] == -1{
                RN[x.0] = 0
            }
            let resultado = Despejar(rn: RN[x.0], cn: CN[x.1], costo: arrMatriz[x.0][x.1].costo)
            
        }*/
    }
    else{
        if true {
            let arMa = arrMatriz
            let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
            newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
            newPaso.setComentario(comentario: "No se puede continuar porque son distintos")
            newPaso.setCeldasValores(matrizValores: arMa)
            pasos.append(newPaso)
        }
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
func DespejarX(n:Double,costo:Double) -> Double{
    if n == 0.0 && costo == 0.0{
        return 0.0
    }
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
