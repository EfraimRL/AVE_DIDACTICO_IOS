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
    var ofertasRestantes:[Double] = []
    var demandasRestantes:[Double] = []
    var comentario:String = ""
    
    //Indices para devolver celdas
    var index = 0
    var indexNomCol = 0
    var indexNomFil = 0
    var indexDemandas = 0
    var indexOfertas = 0
    var indexCeldas = 0
    
    init(filas:Int,columnas:Int) {
        self.filas = filas
        self.columnas = columnas
        totalDeCasillas = (filas + 2) * (columnas + 2)
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
            if (i+y) >= (x){
                if (i+y) == (x){
                    return true
                }
            }
            multiplo = multiplo + 1
            x = (columnas+2) * multiplo
        }
        return false
    }
    func esUltimoRenglon(i:Int) -> Bool {
        if (i >= (totalDeCasillas - (columnas+1))) && (i < (totalDeCasillas-1)){
            return true
        }
        return false
    }
    func setOfertaYDemanda(ofertas:[Double],demandas:[Double]) {
        self.ofertas = ofertas
        self.demandas = demandas
        self.ofertasRestantes = ofertas
        self.demandasRestantes = demandas
        var offer = 0.0
        var demand = 0.0
        for x in ofertas{offer = offer + x}
        for x in demandas{demand = demand + x}
        self.final = "\(offer)/\(demand)"
    }
    func setComentario(comentario:String) {
        self.comentario = comentario
    }
    func getCelda() -> (Any,Int){
        
        //Titulos de las columnas
        if index <= (columnas+1) {
            indexNomCol = indexNomCol+1
            print("Titulo: [\(indexNomCol-1)]")
            self.index = self.index + 1
            return (NombresColumnas[indexNomCol-1],0)
        }
        //Titulos de las filas
        else if esMultiplo(i: index, y: 0){
            indexNomFil = indexNomFil+1
            self.index = self.index + 1
            print("Nombre filas: \(NombresFilas[indexNomFil-1])")
            return (NombresFilas[indexNomFil-1],0)
        }
        //Valores de las demandas
        else if esMultiplo(i: index, y: 1){
            indexDemandas = indexDemandas + 1
            self.index = self.index + 1
            print("Demanda: \(demandas[indexDemandas-1])")
            return ("\(demandas[indexDemandas-1])",0)
        }
        //Valores de las ofertas
        else if esUltimoRenglon(i: index){
            indexOfertas = indexOfertas+1
            self.index = self.index + 1
            print("Oferta: \(ofertas[indexOfertas-1])")
            return ("\(ofertas[indexOfertas-1])",0)
        }
        //Ultima casilla
        else if index == (totalDeCasillas - 1){
            self.index = self.index + 1
            print("Celda final: \(final)")
            return (final,0)
        }
        //Si se pasa reinicia los index
        else if index == totalDeCasillas{
            index = 1
            indexNomCol = 1
            indexNomFil = 0
            indexDemandas = 0
            indexOfertas = 0
            indexCeldas = 0
            print("Titulo: [\(indexNomCol-1)]")
            return (NombresColumnas[indexNomCol-1],0)
        }
        //Celda de valores
        else{
            indexCeldas = indexCeldas + 1
            self.index = self.index + 1
            print("celda \(indexCeldas-1)")
            return (celdas[indexCeldas-1],1)
        }
    }
}

class Celda {
    var valor:Double = 0
    var costo:Double = 0.0
    var color:Int = 0
    var asignado:Bool = False
}
