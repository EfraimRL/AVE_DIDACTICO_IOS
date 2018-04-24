//
//  Paso.swift
//  AVE_DIDACTICO_IOS
//
//  Created by MAC 2 on 24/04/18.
//  Copyright © 2018 BryanMtz. All rights reserved.
//

import Foundation

class Paso {
    var totalDeCasillas:Int = 0
    var filas = 0
    var columnas = 0
    
    var NombresColumnas: [String] = []
    var NombresFilas: [String] = []
    var final:String = "0/0"
    var celdas:[Celda] = []
    var ofertas:[Double] = []
    var demandas:[Double] = []
    
    var index = 0
    init(filas:Int,columnas:Int) {
        self.filas = filas
        self.columnas = columnas
        totalDeCasillas = (filas + 2)(columnas + 2)
        for i in 0 ... columnas {
            if i==0{
                NombresColumnas.append("F/B")
            }
            else{
                NombresColumnas.append("B\(i)")
            }
        }
        NombresColumnas.append("DEM")
        for i in 1 ... filas{
            NombresFilas.append("F\(i)")
        }
        NombresFilas.append("OF")
    }
    func setCeldasValores(matrizValores:[[Celda]]) {
        for x in matrizValores {
            for y in x{
                celdas.append(y)
            }
        }
    }
    func esMultiplo(i:Int,y:Int) -> Bool {
        var x = columnas + 2
        var multiplo = 1
        while x < totalDeCasillas {
            if i >= (x-y){
                if i == (x-y){
                    return true
                }
            }
            multiplo = multiplo + 1
            x = x * multiplo
        }
        return false
    }
    func esUltimoRenglon(i:Int) -> Bool {
        if (i >= (totalDeCasillas - (columnas+1))) && (i < totalDeCasillas){
            return true
        }
    }
    func setOfertaYDemanda(ofertas:[Double],demandas:[Double]) {
        self.ofertas = ofertas
        self.demandas = demandas
        var offer = 0.0
        var demand = 0.0
        for x in ofertas{offer = offer + x}
        for x in demand{demand = demand + x}
        self.final = "\(offer)/\(demand)"
    }
    func getCelda() -> Any{
        var cell = Any
        //Si index es 0 devuelve la
        self.index = self.index + 1
        return cell
    }
}

class Celda {
    var valor:Int = 0
    var costo:Double = 0.0
    var color:UIColor = UIColor.white()
}
