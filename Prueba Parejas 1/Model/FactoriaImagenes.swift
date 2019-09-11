//
//  FactoriaImagenes.swift
//  Prueba Parejas 1
//
//  Created by admin on 01/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FactoriaImagenes{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //----------------------------------------------------------------------------------------------
    //obtener numero de parejas.
    func obtenerCount6Parejas()->Int{
        let arrayImagenes = leerGaleria10Parejas()
        return arrayImagenes.count
    }
    
    func obtenerCount10Parejas()->Int{
        let arrayImagenes = leerGaleria10Parejas()
        return arrayImagenes.count
    }
    
    func obtenerCount12Parejas()->Int{
        let arrayImagenes = leerGaleria12Parejas()
        return arrayImagenes.count
    }
    func obtenerCount15Parejas()->Int{
        let arrayImagenes = leerGaleria15Parejas()
        return arrayImagenes.count
    }
    func obtenerCount18Parejas()->Int{
        let arrayImagenes = leerGaleria18Parejas()
        return arrayImagenes.count
    }
    func obtenerCount21Parejas()->Int{
        let arrayImagenes = leerGaleria21Parejas()
        return arrayImagenes.count
    }
    
    
    //----------------------------------------------------------------------------------------------
    //leer galeria.
    
    func leerGaleria6Parejas() ->[GaleriaFotos6]{
        do {
            let cartasGaleria6Parejas = try context.fetch(GaleriaFotos6.fetchRequest()) as! [GaleriaFotos6]
            return cartasGaleria6Parejas
            
        } catch  {
            print("error al cargar imagenes de la galeria de 6 parejas")
        }
        return []
    }
    
    func leerGaleria10Parejas() ->[GaleriaFotos10]{
        do {
            let cartasGaleria10Parejas = try context.fetch(GaleriaFotos10.fetchRequest()) as! [GaleriaFotos10]
            return cartasGaleria10Parejas
            
        } catch  {
            print("error al cargar imagenes de la galeria de 10 parejas")
        }
        return []
    }
    
    func leerGaleria12Parejas() ->[GaleriaFotos12]{
        do {
            let cartasGaleria12Parejas = try context.fetch(GaleriaFotos12.fetchRequest()) as! [GaleriaFotos12]
            return cartasGaleria12Parejas
            
        } catch  {
            print("error al cargar imagenes de la galeria de 12 parejas")
        }
        return []
    }
    
    func leerGaleria15Parejas() ->[GaleriaFotos15]{
        do {
            let cartasGaleria15Parejas = try context.fetch(GaleriaFotos15.fetchRequest()) as! [GaleriaFotos15]
            return cartasGaleria15Parejas
            
        } catch  {
            print("error al cargar imagenes de la galeria de 10 parejas")
        }
        return []
    }
    
    func leerGaleria18Parejas() ->[GaleriaFotos18]{
        do {
            let cartasGaleria18Parejas = try context.fetch(GaleriaFotos18.fetchRequest()) as! [GaleriaFotos18]
            return cartasGaleria18Parejas
            
        } catch  {
            print("error al cargar imagenes de la galeria de 18 parejas")
        }
        return []
    }
    
    func leerGaleria21Parejas() ->[GaleriaFotos21]{
        do {
            let cartasGaleria21Parejas = try context.fetch(GaleriaFotos21.fetchRequest()) as! [GaleriaFotos21]
            return cartasGaleria21Parejas
            
        } catch  {
            print("error al cargar imagenes de la galeria de 21 parejas")
        }
        return []
    }
    
    

    
    
    //----------------------------------------------------------------------------------------------
    //crear imagenes por defecto.
    
    func crearImagenesPorDefecto6Parejas(){
        var arrayImagenes = leerGaleria6Parejas()
        //obtener la imagen por defecto
        guard let imagenDefectoSinEsclar = UIImage(named: "imagenPorDefecto") else { print("fallo imagen");  return }
        let imagenDefecto = resizeImage(image: imagenDefectoSinEsclar)
        
        for i in 0...5{
            let carta = GaleriaFotos6(context: context)
            carta.imagen = imagenDefecto.pngData()
            carta.indice = Int16(i) + 1000  //con la imagen por defecto el valor del indice es 1000 + el numero de indice correspondiente.
            arrayImagenes.append(carta)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("error al guardar carta en coredata. \(error), \(error.userInfo)")
        }
    }
    
    func crearImagenesPorDefecto10Parejas(){
        var arrayImagenes = leerGaleria10Parejas()
        //obtener la imagen por defecto
        guard let imagenDefectoSinEsclar = UIImage(named: "imagenPorDefecto") else { print("fallo imagen");  return }
        let imagenDefecto = resizeImage(image: imagenDefectoSinEsclar)
        
        for i in 0...9{
            let carta = GaleriaFotos10(context: context)
            carta.imagen = imagenDefecto.pngData()
            carta.indice = Int16(i) + 1000  //con la imagen por defecto el valor del indice es 1000 + el numero de indice correspondiente.
            arrayImagenes.append(carta)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("error al guardar carta en coredata. \(error), \(error.userInfo)")
        }
    }
    
    func crearImagenesPorDefecto12Parejas(){
        var arrayImagenes = leerGaleria12Parejas()
        //obtener la imagen por defecto
        guard let imagenDefectoSinEsclar = UIImage(named: "imagenPorDefecto") else { print("fallo imagen");  return }
        let imagenDefecto = resizeImage(image: imagenDefectoSinEsclar)
        for i in 0...11{
            let carta = GaleriaFotos12(context: context)
            carta.imagen = imagenDefecto.pngData()
            carta.indice = Int16(i) + 1000  //con la imagen por defecto el valor del indice es 1000 + el numero de indice correspondiente.
            arrayImagenes.append(carta)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("error al guardar carta en coredata. \(error), \(error.userInfo)")
        }
    }
    
    func crearImagenesPorDefecto15Parejas(){
        var arrayImagenes = leerGaleria15Parejas()
        //obtener la imagen por defecto
        guard let imagenDefectoSinEsclar = UIImage(named: "imagenPorDefecto") else { print("fallo imagen");  return }
        let imagenDefecto = resizeImage(image: imagenDefectoSinEsclar)
        for i in 0...14{
            let carta = GaleriaFotos15(context: context)
            carta.imagen = imagenDefecto.pngData()
            carta.indice = Int16(i) + 1000  //con la imagen por defecto el valor del indice es 1000 + el numero de indice correspondiente.
            arrayImagenes.append(carta)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("error al guardar carta en coredata. \(error), \(error.userInfo)")
        }
    }
    
    func crearImagenesPorDefecto18Parejas(){
        var arrayImagenes = leerGaleria18Parejas()
        //obtener la imagen por defecto
        guard let imagenDefectoSinEsclar = UIImage(named: "imagenPorDefecto") else { print("fallo imagen");  return }
        let imagenDefecto = resizeImage(image: imagenDefectoSinEsclar)
        for i in 0...17{
            let carta = GaleriaFotos18(context: context)
            carta.imagen = imagenDefecto.pngData()
            carta.indice = Int16(i) + 1000  //con la imagen por defecto el valor del indice es 1000 + el numero de indice correspondiente.
            arrayImagenes.append(carta)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("error al guardar carta en coredata. \(error), \(error.userInfo)")
        }
    }
    
    func crearImagenesPorDefecto21Parejas(){
        var arrayImagenes = leerGaleria21Parejas()
        //obtener la imagen por defecto
        guard let imagenDefectoSinEsclar = UIImage(named: "imagenPorDefecto") else { print("fallo imagen");  return }
        let imagenDefecto = resizeImage(image: imagenDefectoSinEsclar)
        
        for i in 0...20{
            let carta = GaleriaFotos21(context: context)
            carta.imagen = imagenDefecto.pngData()
            carta.indice = Int16(i) + 1000  //con la imagen por defecto el valor del indice es 1000 + el numero de indice correspondiente.
            arrayImagenes.append(carta)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("error al guardar carta en coredata. \(error), \(error.userInfo)")
        }
    }
    
    //----------------------------------------------------------------------------------------------
    //cambiar carta.
    
    func cambiarCarta<T>(numeroTableroActual: Int, carta: UIImage, indice: Int, porDefecto: Bool, arrayBD: [T]){
        
        let arrayPostalesGenerico = arrayBD
        switch numeroTableroActual {
        case 6:
            var arrayPostales = arrayPostalesGenerico as? [GaleriaFotos6]
                arrayPostales! = leerGaleria6Parejas()
                let imagen = carta.pngData()
                
                arrayPostales![indice].imagen = imagen
                
                if porDefecto{
                    
                    arrayPostales![indice].indice = Int16(indice) + 1000
                }
                else{
                    arrayPostales![indice].indice = Int16(indice)
                }
        case 10:
            var arrayPostales = arrayPostalesGenerico as? [GaleriaFotos10]
            arrayPostales! = leerGaleria10Parejas()
            let imagen = carta.pngData()
            
            arrayPostales![indice].imagen = imagen
            
            if porDefecto{
                
                arrayPostales![indice].indice = Int16(indice) + 1000
            }
            else{
                arrayPostales![indice].indice = Int16(indice)
            }
        case 12:
            var arrayPostales = arrayPostalesGenerico as? [GaleriaFotos12]
            arrayPostales! = leerGaleria12Parejas()
            let imagen = carta.pngData()
            
            arrayPostales![indice].imagen = imagen
            
            if porDefecto{
                
                arrayPostales![indice].indice = Int16(indice) + 1000
            }
            else{
                arrayPostales![indice].indice = Int16(indice)
            }
        case 15:
            var arrayPostales = arrayPostalesGenerico as? [GaleriaFotos15]
            arrayPostales! = leerGaleria15Parejas()
            let imagen = carta.pngData()
            
            arrayPostales![indice].imagen = imagen
            
            if porDefecto{
                
                arrayPostales![indice].indice = Int16(indice) + 1000
            }
            else{
                arrayPostales![indice].indice = Int16(indice)
            }
        case 18:
            var arrayPostales = arrayPostalesGenerico as? [GaleriaFotos18]
            arrayPostales! = leerGaleria18Parejas()
            let imagen = carta.pngData()
            
            arrayPostales![indice].imagen = imagen
            
            if porDefecto{
                
                arrayPostales![indice].indice = Int16(indice) + 1000
            }
            else{
                arrayPostales![indice].indice = Int16(indice)
            }
        case 21:
            var arrayPostales = arrayPostalesGenerico as? [GaleriaFotos21]
            arrayPostales! = leerGaleria21Parejas()
            let imagen = carta.pngData()
            
            arrayPostales![indice].imagen = imagen
            
            if porDefecto{
                
                arrayPostales![indice].indice = Int16(indice) + 1000
            }
            else{
                arrayPostales![indice].indice = Int16(indice)
            }
            
        default:
            print("fallo al importar o cambiar la imagen")
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("error al guardar carta en coredata. \(error), \(error.userInfo)")
        }
    }
}
