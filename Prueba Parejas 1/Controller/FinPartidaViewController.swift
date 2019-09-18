//
//  FinPartidaViewController.swift
//  Prueba Parejas 1
//
//  Created by admin on 05/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit


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
        labelCompletado.text = "\(NSLocalizedString("label_completado_1", comment: "")) \(numeroTablero) \(NSLocalizedString("label_completado_2", comment: "")) \(objetivoParejasHechas) \(NSLocalizedString("label_completado_3", comment: ""))"
    }
    
    func nuevoLabelRecord(conseguido: Bool){
        if conseguido{
            labelNuevoRecord.text = NSLocalizedString("label_Nuevo_Record_Conseguido", comment: "muestra que se  ha conseguido un nuevo record")
        }
        else{
            labelNuevoRecord.text = NSLocalizedString("label_Nuevo_Record_Fallado", comment: "muestra que no has conseguido un nuevo record")

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
            labetTiempoRecord.text = NSLocalizedString("label_tiempo_no_record", comment: "sin record") 
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
