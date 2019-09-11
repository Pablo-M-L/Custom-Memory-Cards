//
//  FinPartidaViewController.swift
//  Prueba Parejas 1
//
//  Created by admin on 05/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import QuartzCore

class FinPartidaViewController: UIViewController {

    @IBOutlet weak var labelTiempoHecho: UILabel!
    
    @IBOutlet weak var labetTiempoRecord: UILabel!
    
    @IBOutlet weak var labelCompletado: UILabel!
    
    @IBOutlet weak var labelNuevoRecord: UILabel!
    
    var tiempo = 0
    var objetivoParejasHechas = 0
    var nombreClaveDefault = "tiempoPanel"
    var numeroTablero = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombreClaveDefault += String(numeroTablero) + "Con" + String(objetivoParejasHechas)
        mostrarLabelCompletado()
        mostrarTiempoHecho()
        mostrarRecord()
        comprobarRecord()
        
 
        
        print(nombreClaveDefault)
    }

    func mostrarLabelCompletado(){
        labelCompletado.text = "HAS COMPLETED THE BOARD \(numeroTablero) CARDS, WITH \(objetivoParejasHechas) PAIRS OF CUSTOMIZED CARDS IN : "
    }
    
    func nuevoLabelRecord(conseguido: Bool){
        if conseguido{
            labelNuevoRecord.text = "ALL RIGHT!! YOU HAVE A NEW RECORD"
        }
        else{
            labelNuevoRecord.text = "KEEP TRYING"

        }
    }
    
    func mostrarTiempoHecho(){
        let tiempoFormateado = formatearTiempo(tiempo: tiempo)
        if tiempoFormateado != nil{
            labelTiempoHecho.text = tiempoFormateado
        }
    }
    
    func mostrarRecord(){
        let recordGuardado = UserDefaults.standard.integer(forKey: nombreClaveDefault)
        let tiempoFormateado = formatearTiempo(tiempo: recordGuardado)
        if recordGuardado != 0{
            labetTiempoRecord.text = tiempoFormateado
        }
        else{
            labetTiempoRecord.text = " NO RECORD "
        }
    }
        
    func comprobarRecord(){
            //comprobar y modificar record si es superior.
        let recordGuardado = UserDefaults.standard.integer(forKey: nombreClaveDefault)
        if recordGuardado > 0{
            if self.tiempo < recordGuardado{
                UserDefaults.standard.set(self.tiempo, forKey: nombreClaveDefault)
                nuevoLabelRecord(conseguido: true)
            }
            else{
                nuevoLabelRecord(conseguido: false)
            }
        }
        else{
            nuevoLabelRecord(conseguido: true)
            UserDefaults.standard.set(self.tiempo, forKey: nombreClaveDefault)
        }
    }

    @IBAction func btnNewGame(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BoardViewController {
            vc.numeroTablero = numeroTablero
        }
        
    }

}
