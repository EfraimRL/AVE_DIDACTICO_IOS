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

var RN:[Double] = []
var CN:[Double] = []
var celdasAsignadas = 0

func GenerarPasos(metodo: Metodo){
    //Agega columna o renglon
    balance()
    //Realiza la asingacion de valores con el metodo AVE
    asignacionAVE()
    
    //Cuenta cuantas celdas estan asignadas
    contarAsignaciones()
    
//Si la cantidad de celdas asignadas es igual a la de `R + C -1`
    if ((cantFilas + cantColumnas) - 1) == celdasAsignadas{
//Aqui busca los valores de cada nombre de columna o fila, para buscar un numero negativo R + C + CCA
        var comentario:String = ""
        
        DespejeRyC()
        
        
        
        //Busqueda de las celdas vacias y resultado de R + C + CCV
        if true {
            let arMa = arrMatriz
            let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
            newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
            newPaso.setComentario(comentario: "El siguiente paso es realizar la formula ´R + C + Costo de celda vacia = 0´")
            newPaso.setCeldasValores(matrizValores: arMa)
            pasos.append(newPaso)
        }
        //(coordenadas,valorResultado)
        var arrCeldasVacias:[((Int,Int),Double)] = []
        comentario = "El arreglo de las celdas vacias y el resultado son: \n\n"
        for x in 0 ..< arrMatriz.count{
            for y in 0 ..< arrMatriz[0].count{
                if !arrMatriz[x][y].asignado{
                    let costo:Double = arrMatriz[x][y].costo
                    let resultado:Double = RN[x] + CN[y] + costo
                    comentario = comentario + "R\(x+1) C\(y+1) => R\(x+1)(\(RN[x])) + C\(y+1)(\(CN[y])) + C.C.V.(\(arrMatriz[x][y].costo)) = \(resultado)\n"
//Print
                    print("R\(x+1) C\(y+1) => R\(x+1)(\(RN[x])) + C\(y+1)(\(CN[y])) + C.C.V.(\(arrMatriz[x][y].costo) = \(resultado)\n")
                    arrCeldasVacias.append(((x,y),resultado))
                }
            }
        }
        comentario = comentario + "\nSi hay negativos, se toma el mayor negativo."
        if true {
            let arMa = arrMatriz
            let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
            newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
            newPaso.setComentario(comentario: comentario)
            newPaso.setCeldasValores(matrizValores: arMa)
            pasos.append(newPaso)
        }
//Se verifica que no haya valores negativos
        recorrido = [] //Se limpia el recorrido
        var valorMasNegativo:Double = 0.0
        var coordenadasNegativo:(Int,Int) = (-1,-1)
        for x in arrCeldasVacias{
            if x.1 < valorMasNegativo{
                coordenadasNegativo = x.0
                valorMasNegativo = x.1
//Print
                print("Nuevo Negativo: (\(coordenadasNegativo)), \(valorMasNegativo)")
            }
        }
//Comienza la busqueda del recorrido
        if valorMasNegativo < 0 {
            comentario = "Hay al menos un valor negativo, se busca un recorrido y se hace el ajuste"
            recorrido.append(coordenadasNegativo)
            if BuscarRecorrido(coordIni: coordenadasNegativo, vertical: true, positivo: true, coordActual: coordenadasNegativo, contador: 1){
                comentario = "Encontro un recorrido"
            }
            else if BuscarRecorrido(coordIni: coordenadasNegativo, vertical: false, positivo: true, coordActual: coordenadasNegativo, contador: 1){
                comentario = "Encontro un recorrido"
            }
            else{
                comentario = "No encontro un recorrido"
                recorrido.popLast()
            }
            if comentario != "No encontro un recorrido"{
                var auxBool = true
                var newArrMatriz = arrMatriz
                for pos in recorrido{
                    if auxBool{
                        newArrMatriz[pos.0][pos.1].signo = 1
                    }
                    if !auxBool{
                        newArrMatriz[pos.0][pos.1].signo = -1
                    }
                    auxBool = !auxBool
                }
                comentario = comentario + "A las celdas de color verde se les va a sumar el valor mas bajo de las celdas en rojo y a las celdas en rojo se les suma este mismo valor"
                if true {
                    
                    let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
                    newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
                    newPaso.setComentario(comentario: comentario)
                    newPaso.setCeldasValores(matrizValores: newArrMatriz)
                    pasos.append(newPaso)
                }
    //Busqueda de la celda negativa con menor valor
                var minValor = 999999999.9
                for x in 0 ..< arrMatriz.count{
                    for y in 0 ..< arrMatriz[0].count{
                        if newArrMatriz[x][y].signo == -1{
                            if newArrMatriz[x][y].valor < minValor{
                                minValor = newArrMatriz[x][y].valor
                            }
                        }
                    }
                }
                //Cambio de los valores a la matriz, suma y resta
                for x in 0 ..< arrMatriz.count{
                    for y in 0 ..< arrMatriz[0].count{
                        if newArrMatriz[x][y].signo == -1{
                            arrMatriz[x][y].valor = arrMatriz[x][y].valor - minValor
                            if arrMatriz[x][y].valor == 0.0{
                                arrMatriz[x][y].asignado = false
                            }
                            else{
                                arrMatriz[x][y].asignado = true
                            }
                        }
                        if newArrMatriz[x][y].signo == 1{
                            arrMatriz[x][y].valor = arrMatriz[x][y].valor + minValor
                            if arrMatriz[x][y].valor == 0.0{
                                arrMatriz[x][y].asignado = false
                            }
                            else{
                                arrMatriz[x][y].asignado = true
                            }
                        }
                    }
                }
                if true {
                    let arMa = arrMatriz
                    let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
                    newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
                    newPaso.setComentario(comentario: "Tabla despues de hacer las sumas y restas")
                    newPaso.setCeldasValores(matrizValores: arMa)
                    pasos.append(newPaso)
                }
            }
        }
//Termina la busqueda del recorrido

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
    
    iteracionActual = 0
}
var recorrido:[(Int,Int)] = []
func BuscarRecorrido(coordIni:(Int,Int),vertical:Bool,positivo:Bool,coordActual:(Int,Int),contador:Int) -> Bool{
//Print
    //print("Recorrido \(coordIni) -- \(coordActual)")
    let resultado = false
    if vertical{
        //Busca hacia arriba
        for x in (0 ... coordActual.0).reversed(){
//Print
            //print("x \(x)")
            if x == coordIni.0 && coordIni.1 == coordActual.1{
                continue
            }
            if coordActual.0 == x{
                continue
            }
            if arrMatriz[x][coordActual.1].asignado{
                recorrido.append((x,coordActual.1))
                if contador > 2{
                    if x == coordIni.0 || coordIni.1 == coordActual.1{
                        for j in recorrido{
//Print
                            //print("Recorrido\(j)")
                        }
                        return true
                    }
                }
                if BuscarRecorrido(coordIni: coordIni, vertical: !vertical, positivo: !positivo, coordActual: (x,coordActual.1), contador: contador+1){
                    return true
                }
            }
        }
        //Busca hacia abajo
        for x in coordActual.0 ..< arrMatriz.count{
            if x == coordIni.0 && coordIni.1 == coordActual.1{
                continue
            }
            if coordActual.0 == x{
                continue
            }
            if arrMatriz[x][coordActual.1].asignado{
                recorrido.append((x,coordActual.1))
                if contador > 2{
                    print("contador \(contador)")
                    if x == coordIni.0 || coordIni.1 == coordActual.1{
                        for j in recorrido{
//Print
                            //print("Recorrido\(j)")
                        }
                        return true
                    }
                }
                if BuscarRecorrido(coordIni: coordIni, vertical: !vertical, positivo: !positivo, coordActual: (x,coordActual.1), contador: contador+1){
                    return true
                }
            }
        }
    }
    else if !vertical{
        //Busca hacia la derecha
        for y in coordActual.1 ..< arrMatriz[0].count{
            if coordActual.0 == coordIni.0 && coordIni.1 == y{
                continue
            }
            if coordActual.1 == y{
                continue
            }
            if arrMatriz[coordActual.0][y].asignado{
                recorrido.append((coordActual.0,y))
                if contador > 2{
                    if coordActual.0 == coordIni.0 || coordIni.1 == y{
                        for j in recorrido{
//print
                            //print("Recorrido\(j)")
                        }
                        return true
                    }
                }
                if BuscarRecorrido(coordIni: coordIni, vertical: !vertical, positivo: !positivo, coordActual: (coordActual.0,y), contador: contador+1){
                    return true
                }
            }
        }
        //Busca hacia la izquierda
        for y in (0 ... coordActual.1).reversed(){
            if coordActual.0 == coordIni.0 && coordIni.1 == y{
                continue
            }
            if coordActual.1 == y{
                continue
            }
            if arrMatriz[coordActual.0][y].asignado{
                recorrido.append((coordActual.0,y))
                if contador > 2{
                    if coordActual.0 == coordIni.0 || coordIni.1 == y{
                        for j in recorrido{
//Print
                            //print("Recorrido\(j)")
                        }
                        return true
                    }
                }
                if BuscarRecorrido(coordIni: coordIni, vertical: !vertical, positivo: !positivo, coordActual: (coordActual.0,y), contador: contador+1){
                    return true
                }
            }
        }
    }
    
    return resultado
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
//Balance
func balance(){
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
}
func asignacionAVE(){
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
        newPaso.setComentario(comentario: "Asignacion terminada. \nSe prosigue a verificar las asignaciones ´#R + #C - 1 = Celdas asignadas´")
        newPaso.setCeldasValores(matrizValores: arMa)
        pasos.append(newPaso)
    }
    
}
func contarAsignaciones(){
    var arrCeldas:[(Int,Int)] = []
    celdasAsignadas = 0
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
    RN = []
    CN = []
    for _ in 0 ..< cantColumnas {RN.append(-999)}
    for _ in 0 ..< cantFilas {CN.append(-999)}
    
    //Agrega la tabla antes para validar la comparacion
    if true {
        let arMa = arrMatriz
        let newPaso = Paso(filas: cantFilas, columnas: cantColumnas)
        newPaso.setOfertaYDemanda(ofertas: precioColumnasConstante, demandas: precioFilasConstante)
        newPaso.setComentario(comentario: "´#R + #C - 1 = Celdas asignadas´\n\(cantFilas) + \(cantColumnas) - 1 = \(celdasAsignadas)")
        newPaso.setCeldasValores(matrizValores: arMa)
        pasos.append(newPaso)
    }
}
func DespejeRyC(){
    var comentario = "Para la optimizaciòn, se busca el renglon(R#) o columna(C#) con mayor asignaciones, y se le da el valor de 0.\n"
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
            aux = false
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
            aux = false
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

}
