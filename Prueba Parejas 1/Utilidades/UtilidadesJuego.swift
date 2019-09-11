//
//  UtilidadesJuego.swift
//  Prueba Parejas 1
//
//  Created by admin on 02/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

func resizeImage(image: UIImage)->UIImage{
    
    let marco = UIImage(named: "marcoNegro")!
    let originalSize = image.size
    //obtener factor de escalado
    let witdhRatio = 200 / originalSize.width
    let heightRatio = 300 / originalSize.height
    
    let targerRatio = max(witdhRatio, heightRatio)
    let newSize = CGSize(width: originalSize.width * targerRatio, height: originalSize.height * targerRatio)
    
    //definir el rectangulo. (la zona donde se va a renderizar)
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    let rectImagen = CGRect(x: 9, y: 6, width: newSize.width - 18, height: newSize.height - 12)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    marco.draw(in: rect)
    image.draw(in: rectImagen)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    //destapar nuevaImagen que es UIImage?
    guard let nuevaImagen = newImage else {
        return image
    }
    return nuevaImagen
    
}

//crea un array de 12 cartas a partir del array de 8 cartas de la base de datos.
func crearArray6ParejasAleatorias(arrayCartas: [GaleriaFotos6])-> [GaleriaFotos6]{
    var array6ParesA = arrayCartas
    var array6ParesB = arrayCartas
    var array6ParesAleatorio = [GaleriaFotos6]()
    
    
    while array6ParesA.count > 0{
        
        guard let cartaAleatoria = array6ParesA.randomElement() else {return []}
        guard let numeroIndiceItem = array6ParesA.firstIndex(of: cartaAleatoria) else{ return []}
        array6ParesAleatorio.append(cartaAleatoria)
        array6ParesA.remove(at: numeroIndiceItem)
    }
    
    while array6ParesB.count > 0{
        
        guard let cartaAleatoria = array6ParesB.randomElement() else {return []}
        guard let numeroIndiceItem = array6ParesB.firstIndex(of: cartaAleatoria) else{ return []}
        array6ParesAleatorio.append(cartaAleatoria)
        array6ParesB.remove(at: Int(numeroIndiceItem))
    }
    return array6ParesAleatorio
}

//crea un array de 20 cartas a partir del array de 8 cartas de la base de datos.
func crearArray10ParejasAleatorias(arrayCartas: [GaleriaFotos10])-> [GaleriaFotos10]{
    var array10ParesA = arrayCartas
    var array10ParesB = arrayCartas
    var array10ParesAleatorio = [GaleriaFotos10]()
    
    
    while array10ParesA.count > 0{

        guard let cartaAleatoria = array10ParesA.randomElement() else {return []}
        guard let numeroIndiceItem = array10ParesA.firstIndex(of: cartaAleatoria) else{ return []}
        array10ParesAleatorio.append(cartaAleatoria)
        array10ParesA.remove(at: numeroIndiceItem)
    }
    
    while array10ParesB.count > 0{

        guard let cartaAleatoria = array10ParesB.randomElement() else {return []}
        guard let numeroIndiceItem = array10ParesB.firstIndex(of: cartaAleatoria) else{ return []}
        array10ParesAleatorio.append(cartaAleatoria)
        array10ParesB.remove(at: Int(numeroIndiceItem))
    }
    return array10ParesAleatorio
}

func crearArray12ParejasAleatorias(arrayCartas: [GaleriaFotos12])-> [GaleriaFotos12]{
    var array12ParesA = arrayCartas
    var array12ParesB = arrayCartas
    var array12ParesAleatorio = [GaleriaFotos12]()
    
    
    while array12ParesA.count > 0{
        
        guard let cartaAleatoria = array12ParesA.randomElement() else {return []}
        guard let numeroIndiceItem = array12ParesA.firstIndex(of: cartaAleatoria) else{ return []}
        array12ParesAleatorio.append(cartaAleatoria)
        array12ParesA.remove(at: numeroIndiceItem)
    }
    
    while array12ParesB.count > 0{
        
        guard let cartaAleatoria = array12ParesB.randomElement() else {return []}
        guard let numeroIndiceItem = array12ParesB.firstIndex(of: cartaAleatoria) else{ return []}
        array12ParesAleatorio.append(cartaAleatoria)
        array12ParesB.remove(at: Int(numeroIndiceItem))
    }
    return array12ParesAleatorio
}

func crearArray15ParejasAleatorias(arrayCartas: [GaleriaFotos15])-> [GaleriaFotos15]{
    var array15ParesA = arrayCartas
    var array15ParesB = arrayCartas
    var array15ParesAleatorio = [GaleriaFotos15]()
    
    
    while array15ParesA.count > 0{
        
        guard let cartaAleatoria = array15ParesA.randomElement() else {return []}
        guard let numeroIndiceItem = array15ParesA.firstIndex(of: cartaAleatoria) else{ return []}
        array15ParesAleatorio.append(cartaAleatoria)
        array15ParesA.remove(at: numeroIndiceItem)
    }
    
    while array15ParesB.count > 0{
        
        guard let cartaAleatoria = array15ParesB.randomElement() else {return []}
        guard let numeroIndiceItem = array15ParesB.firstIndex(of: cartaAleatoria) else{ return []}
        array15ParesAleatorio.append(cartaAleatoria)
        array15ParesB.remove(at: Int(numeroIndiceItem))
    }
    return array15ParesAleatorio
}

func crearArray18ParejasAleatorias(arrayCartas: [GaleriaFotos18])-> [GaleriaFotos18]{
    var array18ParesA = arrayCartas
    var array18ParesB = arrayCartas
    var array18ParesAleatorio = [GaleriaFotos18]()
    
    
    while array18ParesA.count > 0{
        
        guard let cartaAleatoria = array18ParesA.randomElement() else {return []}
        guard let numeroIndiceItem = array18ParesA.firstIndex(of: cartaAleatoria) else{ return []}
        array18ParesAleatorio.append(cartaAleatoria)
        array18ParesA.remove(at: numeroIndiceItem)
    }
    
    while array18ParesB.count > 0{
        
        guard let cartaAleatoria = array18ParesB.randomElement() else {return []}
        guard let numeroIndiceItem = array18ParesB.firstIndex(of: cartaAleatoria) else{ return []}
        array18ParesAleatorio.append(cartaAleatoria)
        array18ParesB.remove(at: Int(numeroIndiceItem))
    }
    return array18ParesAleatorio
}

func crearArray21ParejasAleatorias(arrayCartas: [GaleriaFotos21])-> [GaleriaFotos21]{
    var array21ParesA = arrayCartas
    var array21ParesB = arrayCartas
    var array21ParesAleatorio = [GaleriaFotos21]()
    
    
    while array21ParesA.count > 0{
        
        guard let cartaAleatoria = array21ParesA.randomElement() else {return []}
        guard let numeroIndiceItem = array21ParesA.firstIndex(of: cartaAleatoria) else{ return []}
        array21ParesAleatorio.append(cartaAleatoria)
        array21ParesA.remove(at: numeroIndiceItem)
    }
    
    while array21ParesB.count > 0{
        
        guard let cartaAleatoria = array21ParesB.randomElement() else {return []}
        guard let numeroIndiceItem = array21ParesB.firstIndex(of: cartaAleatoria) else{ return []}
        array21ParesAleatorio.append(cartaAleatoria)
        array21ParesB.remove(at: Int(numeroIndiceItem))
    }
    return array21ParesAleatorio
}

func pasarBDaTuplasUtil(numeroTablero: Int, tabla6: [GaleriaFotos6], tabla10: [GaleriaFotos10], tabla12: [GaleriaFotos12], tabla15: [GaleriaFotos15], tabla18: [GaleriaFotos18], tabla21: [GaleriaFotos21]) ->  [(imagen: UIImage, indice: Int)]{
    var arrayTuplaCartas = [(imagen: UIImage,indice: Int)]()
    let factoriaCartas = FactoriaImagenes()
    
    switch numeroTablero {
    case 12:
        var tabla6 = tabla6
        tabla6 = factoriaCartas.leerGaleria6Parejas()
        if tabla6.isEmpty{
            factoriaCartas.crearImagenesPorDefecto6Parejas()
            tabla6 = factoriaCartas.leerGaleria6Parejas()
        }
        for i in 0...(tabla6.count - 1){
            //generamos el array de tuplas con una imagen e indice, obtenidos de la base de datos correspondiente.
            let imagen = UIImage(data: (tabla6[i].imagen)!) //para poder destaparla antes, crea la imagen.
            arrayTuplaCartas.append((imagen!, Int(tabla6[i].indice)))
        }
        
    case 20:
        var tabla10 = tabla10
        tabla10 = factoriaCartas.leerGaleria10Parejas()
        if tabla10.isEmpty{
            factoriaCartas.crearImagenesPorDefecto10Parejas()
            tabla10 = factoriaCartas.leerGaleria10Parejas()
        }
        
        for i in 0...(tabla10.count - 1){
            let imagen = UIImage(data: (tabla10[i].imagen)!)
            arrayTuplaCartas.append((imagen!, Int(tabla10[i].indice)))
        }
        
    case 24:
        var tabla12 = tabla12
        tabla12 = factoriaCartas.leerGaleria12Parejas()
        if tabla12.isEmpty{
            factoriaCartas.crearImagenesPorDefecto12Parejas()
            tabla12 = factoriaCartas.leerGaleria12Parejas()
        }
        
        for i in 0...(tabla12.count - 1){
            let imagen = UIImage(data: (tabla12[i].imagen)!)
            arrayTuplaCartas.append((imagen!, Int(tabla12[i].indice)))
        }
        
    case 30:
        var tabla15 = tabla15
        tabla15 = factoriaCartas.leerGaleria15Parejas()
        if tabla15.isEmpty{
            factoriaCartas.crearImagenesPorDefecto15Parejas()
            tabla15 = factoriaCartas.leerGaleria15Parejas()
        }
        
        for i in 0...(tabla15.count - 1){
            let imagen = UIImage(data: (tabla15[i].imagen)!)
            arrayTuplaCartas.append((imagen!, Int(tabla15[i].indice)))
        }
        
    case 36:
        var tabla18 = tabla18
        tabla18 = factoriaCartas.leerGaleria18Parejas()
        if tabla18.isEmpty{
            factoriaCartas.crearImagenesPorDefecto18Parejas()
            tabla18 = factoriaCartas.leerGaleria18Parejas()
        }
        
        for i in 0...(tabla18.count - 1){
            let imagen = UIImage(data: (tabla18[i].imagen)!)
            arrayTuplaCartas.append((imagen!, Int(tabla18[i].indice)))
        }
        
    case 42:
        var tabla21 = tabla21
        tabla21 = factoriaCartas.leerGaleria21Parejas()
        if tabla21.isEmpty{
            factoriaCartas.crearImagenesPorDefecto21Parejas()
            tabla21 = factoriaCartas.leerGaleria21Parejas()
        }
        
        for i in 0...(tabla21.count - 1){
            let imagen = UIImage(data: (tabla21[i].imagen)!)
            arrayTuplaCartas.append((imagen!, Int(tabla21[i].indice)))
        }
        
    default:
        print("sin tablero")
    }
    return arrayTuplaCartas
}

func pasarBDpartidaAtuplasUtil(numeroTablero: Int ,partida6: [GaleriaFotos6], partida10: [GaleriaFotos10], partida12: [GaleriaFotos12], partida15: [GaleriaFotos15], partida18: [GaleriaFotos18], partida21: [GaleriaFotos21])  ->  [(imagen: UIImage, indice: Int)]{
    var arrayParesTuplaCartas = [(imagen: UIImage,indice: Int)]()
    switch numeroTablero {
    case 12:
        for i in 0...11{
            //generamos el array de tuplas con una imagen e indice, obtenidos de la base de datos correspondiente.
            let imagen = UIImage(data: (partida6[i].imagen)!) //para poder destaparla antes, crea la imagen.
            arrayParesTuplaCartas.append((imagen!, Int(partida6[i].indice)))
        }
    case 20:
        for i in 0...19{
            //generamos el array de tuplas con una imagen e indice, obtenidos de la base de datos correspondiente.
            let imagen = UIImage(data: (partida10[i].imagen)!) //para poder destaparla antes, crea la imagen.
            arrayParesTuplaCartas.append((imagen!, Int(partida10[i].indice)))
        }
        
    case 24:
        for i in 0...23{
            //generamos el array de tuplas con una imagen e indice, obtenidos de la base de datos correspondiente.
            let imagen = UIImage(data: (partida12[i].imagen)!) //para poder destaparla antes, crea la imagen.
            arrayParesTuplaCartas.append((imagen!, Int(partida12[i].indice)))
        }
        
    case 30:
        for i in 0...29{
            //generamos el array de tuplas con una imagen e indice, obtenidos de la base de datos correspondiente.
            let imagen = UIImage(data: (partida15[i].imagen)!) //para poder destaparla antes, crea la imagen.
            arrayParesTuplaCartas.append((imagen!, Int(partida15[i].indice)))
        }
        
    case 36:
        for i in 0...35{
            //generamos el array de tuplas con una imagen e indice, obtenidos de la base de datos correspondiente.
            let imagen = UIImage(data: (partida18[i].imagen)!) //para poder destaparla antes, crea la imagen.
            arrayParesTuplaCartas.append((imagen!, Int(partida18[i].indice)))
        }
        
    case 42:
        for i in 0...41{
            //generamos el array de tuplas con una imagen e indice, obtenidos de la base de datos correspondiente.
            let imagen = UIImage(data: (partida21[i].imagen)!) //para poder destaparla antes, crea la imagen.
            arrayParesTuplaCartas.append((imagen!, Int(partida21[i].indice)))
        }
    default:
        print("sin partida")
    }
    
    return arrayParesTuplaCartas
}

func convertirIndiceSegunTablero(tableroJuego: Int, indiceCartaPulsada: Int) -> Int{
    switch tableroJuego {
    case 12:
        switch indiceCartaPulsada{
        //fila 1
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 3
        //fila 2
        case 7:
            return 4
        case 8:
            return 5
        case 9:
            return 6
        case 10:
            return 7
        //fila 3
        case 14:
            return 8
        case 15:
            return 9
        case 16:
            return 10
        case 17:
            return 11
        default:
            return 0
        }
    case 20:
        switch indiceCartaPulsada{
        //fila 1
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 3
        case 4:
            return 4
        //fila 2
        case 7:
            return 5
        case 8:
            return 6
        case 9:
            return 7
        case 10:
            return 8
        case 11:
            return 9
        //fila 3
        case 14:
            return 10
        case 15:
            return 11
        case 16:
            return 12
        case 17:
            return 13
        case 18:
            return 14
            //fila 4
        case 21:
            return 15
        case 22:
            return 16
        case 23:
            return 17
        case 24:
            return 18
        case 25:
            return 19
        default:
            return 0
        }
    case 24:
        switch indiceCartaPulsada{
        //fila 1
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 3
        case 4:
            return 4
        case 5:
            return 5
        //fila 2
        case 7:
            return 6
        case 8:
            return 7
        case 9:
            return 8
        case 10:
            return 9
        case 11:
            return 10
        case 12:
            return 11
        //fila 3
        case 14:
            return 12
        case 15:
            return 13
        case 16:
            return 14
        case 17:
            return 15
        case 18:
            return 16
        case 19:
            return 17
        //fila 4
        case 21:
            return 18
        case 22:
            return 19
        case 23:
            return 20
        case 24:
            return 21
        case 25:
            return 22
        case 26:
            return 23
        default:
            return 0
        }
    case 30:
        switch indiceCartaPulsada{
        //fila 1
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 3
        case 4:
            return 4
        case 5:
            return 5
        //fila 2
        case 7:
            return 6
        case 8:
            return 7
        case 9:
            return 8
        case 10:
            return 9
        case 11:
            return 10
        case 12:
            return 11
        //fila 3
        case 14:
            return 12
        case 15:
            return 13
        case 16:
            return 14
        case 17:
            return 15
        case 18:
            return 16
        case 19:
            return 17
        //fila 4
        case 21:
            return 18
        case 22:
            return 19
        case 23:
            return 20
        case 24:
            return 21
        case 25:
            return 22
        case 26:
            return 23
            //fila 5
        case 28:
            return 24
        case 29:
            return 25
        case 30:
            return 26
        case 31:
            return 27
        case 32:
            return 28
        case 33:
            return 29
        default:
            return 0
        }
    case 36:
        switch indiceCartaPulsada{
        //fila 1
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 3
        case 4:
            return 4
        case 5:
            return 5
        //fila 2
        case 7:
            return 6
        case 8:
            return 7
        case 9:
            return 8
        case 10:
            return 9
        case 11:
            return 10
        case 12:
            return 11
        //fila 3
        case 14:
            return 12
        case 15:
            return 13
        case 16:
            return 14
        case 17:
            return 15
        case 18:
            return 16
        case 19:
            return 17
        //fila 4
        case 21:
            return 18
        case 22:
            return 19
        case 23:
            return 20
        case 24:
            return 21
        case 25:
            return 22
        case 26:
            return 23
        //fila 5
        case 28:
            return 24
        case 29:
            return 25
        case 30:
            return 26
        case 31:
            return 27
        case 32:
            return 28
        case 33:
            return 29
            //fila 6
        case 35:
            return 30
        case 36:
            return 31
        case 37:
            return 32
        case 38:
            return 33
        case 39:
            return 34
        case 40:
            return 35
        default:
            return 0
        }
    default:
        return indiceCartaPulsada
    }
}

func deshabilitarHabilitar(carta: UIButton){
    let estadoActual = carta.isEnabled
    carta.isEnabled = !estadoActual
    carta.adjustsImageWhenDisabled = false
}

func formatearTiempo(tiempo: Int) -> String?{
    var tiempoFormateado = ""
    if tiempo > 59{
        let minutosTranscurridos = tiempo / 60
        let segundosTranscurridos = tiempo % 60
        tiempoFormateado = " \(minutosTranscurridos) MINUTES AND \(segundosTranscurridos) SECONDS "
    }
    else if tiempo < 60{
        let segundosTranscurridos = tiempo % 60
        tiempoFormateado = " \(segundosTranscurridos) SECONDS "
    }
    
    return tiempoFormateado
}

