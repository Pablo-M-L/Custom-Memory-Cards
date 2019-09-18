//
//  InstruccionesViewController.swift
//  Prueba Parejas 1
//
//  Created by admin on 16/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class InstruccionesViewController: UIViewController {
    
     let animFlecha = CALayer()
     let imgagenFondo = CALayer()
    
    var pasoNumero = 1

    @IBOutlet weak var textoAyuda: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imagen de pantalla
        //view.layer.backgroundColor = UIColor.gray.cgColor
        imgagenFondo.contents = UIImage(named: "pantallaMenuPrincipal")?.cgImage
        imgagenFondo.bounds = CGRect(x: 0, y: 0, width: view.bounds.size.width / 1.2, height: view.bounds.size.height / 1.2)
        imgagenFondo.position = CGPoint(x: view.frame.midX  , y: view.frame.midY)
        imgagenFondo.borderColor = UIColor.white.cgColor
        imgagenFondo.borderWidth = 2
        imgagenFondo.zPosition = -2
        
        view.layer.addSublayer(imgagenFondo)
        
        //ventana texto
        textoAyuda.bounds = CGRect(x: 0, y: 0, width: view.bounds.size.width / 1.2, height: view.bounds.size.height / 3)
        textoAyuda.layer.position = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height/1.8)
        textoAyuda.isHidden = true
        textoAyuda.layer.borderWidth = 2
        textoAyuda.layer.borderColor = UIColor.blue.cgColor
        
        
        //añadir flecha
        let imagenFlecha = UIImage(named: "flechaIzquierda")?.cgImage
        let anchoFlecha = view.bounds.size.width / 7
        animFlecha.bounds = CGRect(x: 0, y: 0, width: anchoFlecha, height: anchoFlecha)
        animFlecha.position = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height/2.3)
        animFlecha.contents = imagenFlecha
        
        view.layer.addSublayer(animFlecha)
        animBtnComprar()
        
        
    }

    @IBAction func btnNext(_ sender: UIButton) {
        switch pasoNumero {
        case 1:
            animBtnFacebook()
        case 2:
            moverTexto()
            let texto = NSLocalizedString("texto_ayuda_Tablero", comment: "")
            animMostrarTexto(texto: texto)
            animBtnTablero()
        case 3:
            animFlecha.isHidden = true
            imgagenFondo.contents = UIImage(named: "pantallaTablero")?.cgImage
            let texto = NSLocalizedString("texto_ayuda_pantalla_tablero", comment: "")
            animMostrarTexto(texto: texto)
        case 4:
            animFlecha.isHidden = false
            animBtnPersonalizar()
            moverTexto2()
            let texto = NSLocalizedString("texto_ayuda_btnPersonalizar", comment: "")
            animMostrarTexto(texto: texto)
        case 5:
            animFlecha.isHidden = true
            animFlecha.position = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height/3)
            imgagenFondo.contents = UIImage(named: "pantallaPersonalizar")?.cgImage
            let texto = NSLocalizedString("texto_ayuda_pantalla_personalizar", comment: "")
            animMostrarTexto(texto: texto)
            moverTexto()
        case 6:
            animFlecha.isHidden = false
            moverTexto2()
            animBtnImportar()
        default:
            animFlecha.isHidden = true
            let texto = NSLocalizedString("texto_ayuda_fin", comment: "")
            animMostrarTexto(texto: texto)
        }
        pasoNumero += 1
    }
    
    func animMostrarTexto(texto: String){
        textoAyuda.text = texto
        textoAyuda.isHidden = false
        let animationMostrar = CABasicAnimation(keyPath: "transform.scale.x")
        animationMostrar.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationMostrar.fromValue = 0
        animationMostrar.toValue = 1
        animationMostrar.duration = 2
        textoAyuda.layer.add(animationMostrar, forKey: "escale animation")
    }
    
    func animBtnComprar(){
        let animationADS = CABasicAnimation(keyPath: "position")
        animationADS.fromValue = animFlecha.position
        animationADS.toValue = CGPoint(x: view.bounds.size.width / 1.92, y: view.bounds.size.height / 3.4)
        animationADS.duration = 2
        animFlecha.position = CGPoint(x: view.bounds.size.width / 1.92, y: view.bounds.size.height / 3.4)
        animFlecha.add(animationADS, forKey: "basic animation")
        
        let texto = NSLocalizedString("texto_ayuda_btnComprar", comment: "")
        animMostrarTexto(texto: texto)
    }
    
    func animBtnFacebook(){
        let animationFace = CABasicAnimation(keyPath: "position")
        animationFace.fromValue = animFlecha.position
        animationFace.toValue = CGPoint(x: view.bounds.size.width / 1.43, y: view.bounds.size.height/3.4)
        animationFace.duration = 2
        animFlecha.position = CGPoint(x: view.bounds.size.width / 1.43, y: view.bounds.size.height / 3.4)
        animFlecha.add(animationFace, forKey: "basic animation")
        let texto = NSLocalizedString("texto_ayuda_btnFace", comment: "")
        animMostrarTexto(texto: texto)
    }
    
    func animBtnTablero(){
        let animationFace = CABasicAnimation(keyPath: "position")
        animationFace.fromValue = animFlecha.position
        animationFace.toValue = CGPoint(x: view.bounds.size.width / 2.3, y: view.bounds.size.height/1.92)
        animationFace.duration = 2
        animFlecha.position = CGPoint(x: view.bounds.size.width / 2.3, y: view.bounds.size.height / 1.92)
        animFlecha.add(animationFace, forKey: "basic animation")
    }
    
    func animBtnPersonalizar(){
        let animPersonalizar = CABasicAnimation(keyPath: "position")
        animPersonalizar.fromValue = animFlecha.position
        animPersonalizar.toValue = CGPoint(x: view.bounds.size.width / 1.08, y: view.bounds.size.height/6)
        animPersonalizar.duration = 2
        animFlecha.position = CGPoint(x: view.bounds.size.width / 1.08, y: view.bounds.size.height / 6)
        animFlecha.add(animPersonalizar, forKey: "basic animation")
        let texto = NSLocalizedString("texto_ayuda_btnPersonalizar", comment: "")
        animMostrarTexto(texto: texto)
    }
    
    func animBtnImportar(){
        let animPersonalizar = CABasicAnimation(keyPath: "position")
        animPersonalizar.fromValue = animFlecha.position
        animPersonalizar.toValue = CGPoint(x: view.bounds.size.width / 1.08, y: view.bounds.size.height/6)
        animPersonalizar.duration = 2
        animFlecha.position = CGPoint(x: view.bounds.size.width / 1.08, y: view.bounds.size.height / 6)
        animFlecha.add(animPersonalizar, forKey: "basic animation")
        let texto = NSLocalizedString("texto_ayuda_btnImportar", comment: "")
        animMostrarTexto(texto: texto)
    }
    
    func moverTexto(){
        let animText = CABasicAnimation(keyPath: "position")
        animText.fromValue = textoAyuda.layer.position
        animText.toValue = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height/3.5)
        animText.duration = 2
        textoAyuda.layer.position = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 3.5)
        textoAyuda.layer.add(animText, forKey: "basic animation")

    }
    
    func moverTexto2(){
        let animText = CABasicAnimation(keyPath: "position")
        animText.fromValue = textoAyuda.layer.position
        textoAyuda.layer.position = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height/1.8)
        animText.duration = 2
        textoAyuda.layer.position = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height/1.8)
        textoAyuda.layer.add(animText, forKey: "basic animation")
        
    }

    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
