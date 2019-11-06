//
//  BoardViewController.swift
//  Prueba Parejas 1
//
//  Created by admin on 31/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation


class BoardViewController: UIViewController, GADInterstitialDelegate {
    
    var numeroTablero = 0
    var arrayTuplaCartas = [(imagen: UIImage,indice: Int)]()
    var arrayParesTuplaCartas = [(imagen: UIImage,indice: Int)]()
    var defaults = UserDefaults.standard
    var idBanner = ""
    var interstitial: GADInterstitial!
    var interstitialMostrado = false


    @IBAction func btnReiniciarPartida(_ sender: UIButton) {
        reproducirSonido(sonido: playerPulsacion2)
        if !comprobandoTirada{ tiradaNueva()}
    }
    
    @IBOutlet var filaCartas: [UIStackView]!
    
    @IBOutlet var cartaPulsada: [UIButton]!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBAction func btnVolver(_ sender: UIButton) {
        reproducirSonido(sonido: playerPulsacion)
        performSegue(withIdentifier: "segueBoardVuelveMenu", sender: nil)
    }
    
    @IBAction func btnPersonalizar(_ sender: UIButton) {
        reproducirSonido(sonido: playerPulsacion)
    }
    var imagenCarta = UIImage()
    var imagenCarta2 = UIImage()
    var reverso = UIImage()
    
    //tirada
    var indiceBotonCartaPulsado = 0
    var tiradaIniciada = false
    var comprobandoTirada = false
    var indiceCartaAbierta1 = 100 //si no hay una tirada en marcha el valor es 100
    var indiceCartaAbierta2 = 100
    var CartaAgirar = 0
    var numeroCartaConfigurada1 = 0
    var numeroCartaConfigurada2 = 0
    var girandoUnaCarta = false
    
    
    //partida
    var arrayEstadoCartas = [Bool]() //reverso false, anverso true.
    var parejasAcertadas = 0
    var objetivoParejasAcertadas = 0
    var cronometro = Timer()
    var tiempoTranscurrido = 0
    var minutosTrascurridos = 0
    var segundosTrascurridos = 0
    var playerGirar: AVAudioPlayer!
    var playerFallo: AVAudioPlayer!
    var playerAcierto: AVAudioPlayer!
    var playerFinPartida: AVAudioPlayer!
    var playerPulsacion: AVAudioPlayer!
    var playerPulsacion2: AVAudioPlayer!
    
    
    //base de datos.
    var arrayCartas6 = [GaleriaFotos6]() //almacena las 6 cartas de la base de datos configuras en edit o las de defecto al inicio.
    var arrayCartas10 = [GaleriaFotos10]() //almacena las 10 cartas de la base de datos configuras en edit o las de defecto al inicio.
    var arrayCartas12 = [GaleriaFotos12]()
    var arrayCartas15 = [GaleriaFotos15]()
    var arrayCartas18 = [GaleriaFotos18]()
    var arrayCartas21 = [GaleriaFotos21]()
    
    var arrayParesPartida6 = [GaleriaFotos6]() // almacena las 12 cartas de forma aleatoria.
    var arrayParesPartida10 = [GaleriaFotos10]() // almacena las 20 cartas de forma aleatoria.
    var arrayParesPartida12 = [GaleriaFotos12]()
    var arrayParesPartida15 = [GaleriaFotos15]()
    var arrayParesPartida18 = [GaleriaFotos18]()
    var arrayParesPartida21 = [GaleriaFotos21]()
    
    let factoriaCartas = FactoriaImagenes()
    var imagenPorDefecto: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cargar sonidos
        if let soundURL = Bundle.main.url(forResource: "pulsacionBtn", withExtension: "wav"),
           let soundURL2 = Bundle.main.url(forResource: "pulsacionBtn2", withExtension: "wav"),
           let soundURLgirar = Bundle.main.url(forResource: "girarCarta", withExtension: "wav"),
           let soundURLFallida = Bundle.main.url(forResource: "parejaFallada", withExtension: "wav"),
           let soundURLAcertada = Bundle.main.url(forResource: "parejaAcertada", withExtension: "wav"),
           let soundURLFin = Bundle.main.url(forResource: "finPartida", withExtension: "wav"){
            
            do {
                playerPulsacion = try AVAudioPlayer(contentsOf: soundURL)
                playerPulsacion2 = try AVAudioPlayer(contentsOf: soundURL2)
                playerGirar = try AVAudioPlayer(contentsOf: soundURLgirar)
                playerFallo = try AVAudioPlayer(contentsOf: soundURLFallida)
                playerAcierto = try AVAudioPlayer(contentsOf: soundURLAcertada)
                playerFinPartida = try AVAudioPlayer(contentsOf: soundURLFin)
            } catch {
                print(error)
            }
            playerGirar.prepareToPlay()
            playerFallo.prepareToPlay()
            playerAcierto.prepareToPlay()
            playerFinPartida.prepareToPlay()
            playerPulsacion.prepareToPlay()
            playerPulsacion2.prepareToPlay()
        }

        //imagen por defecto en Data.
        guard let imagenReverso = UIImage(named: "reverso") else {return}
        reverso = imagenReverso

        cargarTableroJuego()
        cargarIDBanner()
        
        //comprobar si hay que mostrar publicidad o está comprada.
        let appComprada = defaults.bool(forKey: "com.pablomillanlopez.juegos.CustomMemoryCards")
        if appComprada{
            hideAdmobBanner()
        }
        else{
            leerADs()
            self.interstitial = createAndLoadInterstitial()
            mostrarBannerInt()
        }
    }
    
    func cargarIDBanner(){
        switch numeroTablero {
            case 12:
                idBanner = "ca-app-pub-4831265414200206/5272969211"
            case 20:
                idBanner = "ca-app-pub-4831265414200206/4281992186"
            case 24:
                idBanner = "ca-app-pub-4831265414200206/1795429646"
            case 30:
                idBanner = "ca-app-pub-4831265414200206/9567437441"
            case 36:
                idBanner = "ca-app-pub-4831265414200206/2946188771"
            case 42:
                idBanner = "ca-app-pub-4831265414200206/9487546393"
        default:
            idBanner = "ca-app-pub-4831265414200206/8871267675"
        }
    }
    
    //MARK: bloque Banners
    @objc func leerADs(){
        
        self.bannerView.adUnitID = idBanner
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
        showAdmobBanner()
    }
    
    func showAdmobBanner(){
        self.bannerView.isHidden = false
    }
    
    func hideAdmobBanner(){
        self.bannerView.isHidden = true
    }
    
    //MARK: bloque interstitial
    @objc func mostrarBannerInt(){
        if interstitial.isReady {
            interstitialMostrado = true
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
            if !interstitialMostrado{
            self.perform(#selector(self.mostrarBannerInt), with: nil, afterDelay: 0.3)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        comprobarPararTimer(temporizador: cronometro)
        
        if !interstitialMostrado{
            interstitialMostrado = true
            print(interstitialMostrado)
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-4831265414200206/1412302174")
        let request = GADRequest()
        interstitial.load(request)
        interstitial.delegate = self
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = createAndLoadInterstitial()
    }
    func cargarTableroJuego(){
        //ocultar filas segun el tablero.
        switch numeroTablero {
        case 12://----------------tablero 12 cartas-----------------
            //ocultar botones.
            let rangoAocultar = [4,5,6,11,12,13,18,19,20]
            for indiceBtn in rangoAocultar{
                self.cartaPulsada[indiceBtn].isHidden = true
            }
            //ocultar filas
            for fila in filaCartas{
                if fila.tag > 2{
                    fila.isHidden = true
                }
            }
            
        case 20://----------------tablero 20 cartas-----------------
            let rangoAocultar = [5,6,12,13,19,20,26,27]
            for indiceBtn in rangoAocultar{
                self.cartaPulsada[indiceBtn].isHidden = true
            }
            for fila in filaCartas{
                if fila.tag > 3{
                    fila.isHidden = true
                }
            }
            
        case 24://----------------tablero 24 cartas-----------------
            //ocultar botones.
            let rangoAocultar = [6,13,20,27]
            for indiceBtn in rangoAocultar{
                self.cartaPulsada[indiceBtn].isHidden = true
            }
            for fila in filaCartas{
                if fila.tag > 3{
                    fila.isHidden = true
                }
            }
            
            
        case 30://----------------tablero 30 cartas-----------------
            //ocultar botones.
            let rangoAocultar = [6,13,20,27,34]
            for indiceBtn in rangoAocultar{
                self.cartaPulsada[indiceBtn].isHidden = true
            }
            for fila in filaCartas{
                if fila.tag > 4{
                    fila.isHidden = true
                }
            }
            
        case 36://----------------tablero 36 cartas-----------------
            //ocultar botones.
            let rangoAocultar = [6,13,20,27,34,41]
            for indiceBtn in rangoAocultar{
                self.cartaPulsada[indiceBtn].isHidden = true
            }
        //por defecto cuando el numero de tablero es 42.
        default:
            
            print("fin")
        }
    }

    @IBAction func btnCarta1(_ sender: UIButton) {
        indiceBotonCartaPulsado = sender.tag
        if !comprobandoTirada && !girandoUnaCarta{
            reproducirSonido(sonido: playerGirar)
            //comprobar si es la primera o la segunda carta pulsada. si se pulsa dos veces la misma primera carta se girará y finaliza tirada.
            if !tiradaIniciada{
                indiceCartaAbierta1 = indiceBotonCartaPulsado
                numeroCartaConfigurada1 = convertirIndiceSegunTablero(tableroJuego: numeroTablero, indiceCartaPulsada: sender.tag)
                girandoUnaCarta = true
                girarCarta1()
            }
            else if tiradaIniciada && indiceCartaAbierta1 == indiceBotonCartaPulsado{
                girandoUnaCarta = true
                girarCarta1()
                indiceCartaAbierta1 = 100
            }
            else if tiradaIniciada{
                comprobandoTirada = !comprobandoTirada
                indiceCartaAbierta2 = indiceBotonCartaPulsado
                numeroCartaConfigurada2 = convertirIndiceSegunTablero(tableroJuego: numeroTablero, indiceCartaPulsada: sender.tag)
                girandoUnaCarta = true
                girarCarta2()
                comprobarPareja(carta1: arrayParesTuplaCartas[numeroCartaConfigurada1], carta2: arrayParesTuplaCartas[numeroCartaConfigurada2])
            }}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tiradaNueva()
    }
    
    
    //partidas nuevas.
    func tiradaNueva(){
        //leer base de datos
        objetivoParejasAcertadas = 0
        parejasAcertadas = 0
        indiceCartaAbierta1 = 100
        indiceCartaAbierta2 = 100
        tiradaIniciada = false
        tiempoTranscurrido = 0
        self.cronometro = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(actualizarCronometro), userInfo: nil, repeats: true)
        
        //crea el array de tuplas partiendo de los entity del corel data, y despues genera aleatoriamente el array con el doble de cartas para la partida.
        crearTuplasYpartida()
        
        arrayEstadoCartas = Array(repeating: true, count: 42)
        
        
        calcularParejasAconseguir(objetivo: arrayTuplaCartas)
        
        //comprobar si no hay ninguna paraja y avisar de configurar si no la hay.
        print("tabler: \(numeroTablero) y objetivo: \(objetivoParejasAcertadas)")
        if objetivoParejasAcertadas == 0{
            let alert = UIAlertController(title: NSLocalizedString("titulo_alertTitulo_noparejas", comment: ""), message: NSLocalizedString("titulo_alertMensaje_noparejas", comment: ""), preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title:NSLocalizedString("titulo_alertOK_noparejas", comment: ""), style: .default, handler: {
                action in
                self.performSegue(withIdentifier: "segueBoardToCustom", sender: nil)
            })
            let actionCancel = UIAlertAction(title: NSLocalizedString("titulo_alertCancel_noparejas", comment: ""), style: .default, handler: {
                action in
                self.performSegue(withIdentifier: "segueBoardVuelveMenu", sender: nil)
            })
            
            alert.addAction(actionOK)
            alert.addAction(actionCancel)
            
            present(alert, animated: true)
        }
        
        //poner el tablero con la imagen de reverso y habilitar todas las cartas.
        for i in 0...41{
            cartaPulsada[i].imageEdgeInsets = UIEdgeInsets(top: 2 , left: 3, bottom: 2, right: 3)
            cartaPulsada[i].setImage(reverso, for: .normal)
            cartaPulsada[i].shadowOpacity = 1
            cartaPulsada[i].cornerRadius = 3
            cartaPulsada[i].borderWidth = 3
            cartaPulsada[i].borderColor = UIColor.blue
            self.cartaPulsada[i].isEnabled = true
        }
        
    }
    
    func crearTuplasYpartida(){
        //generar array del tipo del Entity del coredata corespondiente para crear el array con las cartas en orden aleatorio y del mismo tipo.
        switch numeroTablero {
        case 12:
            arrayCartas6 = factoriaCartas.leerGaleria6Parejas()
            if arrayCartas6.isEmpty{
                factoriaCartas.crearImagenesPorDefecto6Parejas()
                arrayCartas6 = factoriaCartas.leerGaleria6Parejas()
            }
            arrayParesPartida6 = crearArray6ParejasAleatorias(arrayCartas: arrayCartas6)
        case 20:
            arrayCartas10 = [GaleriaFotos10]()
            arrayCartas10 = factoriaCartas.leerGaleria10Parejas()
            if arrayCartas10.isEmpty{
                factoriaCartas.crearImagenesPorDefecto10Parejas()
                arrayCartas10 = factoriaCartas.leerGaleria10Parejas()
            }
            arrayParesPartida10 = crearArray10ParejasAleatorias(arrayCartas: arrayCartas10)
        case 24:
            arrayCartas12 = [GaleriaFotos12]()
            arrayCartas12 = factoriaCartas.leerGaleria12Parejas()
            if arrayCartas12.isEmpty{
                factoriaCartas.crearImagenesPorDefecto12Parejas()
                arrayCartas12 = factoriaCartas.leerGaleria12Parejas()
            }
            arrayParesPartida12 = crearArray12ParejasAleatorias(arrayCartas: arrayCartas12)
        case 30:
            arrayCartas15 = [GaleriaFotos15]()
            arrayCartas15 = factoriaCartas.leerGaleria15Parejas()
            if arrayCartas15.isEmpty{
                factoriaCartas.crearImagenesPorDefecto15Parejas()
                arrayCartas15 = factoriaCartas.leerGaleria15Parejas()
            }
            arrayParesPartida15 = crearArray15ParejasAleatorias(arrayCartas: arrayCartas15)
        case 36:
            arrayCartas18 = [GaleriaFotos18]()
            arrayCartas18 = factoriaCartas.leerGaleria18Parejas()
            if arrayCartas18.isEmpty{
                factoriaCartas.crearImagenesPorDefecto18Parejas()
                arrayCartas18 = factoriaCartas.leerGaleria18Parejas()
            }
            arrayParesPartida18 = crearArray18ParejasAleatorias(arrayCartas: arrayCartas18)
        case 42:
            arrayCartas21 = [GaleriaFotos21]()
            arrayCartas21 = factoriaCartas.leerGaleria21Parejas()
            if arrayCartas21.isEmpty{
                factoriaCartas.crearImagenesPorDefecto21Parejas()
                arrayCartas21 = factoriaCartas.leerGaleria21Parejas()
            }
            arrayParesPartida21 = crearArray21ParejasAleatorias(arrayCartas: arrayCartas21)
        default:
            print("no se ha creado parejas aleatorias.")
        }
        
        //pasar los array en tuplas.
        arrayTuplaCartas = []
        arrayTuplaCartas = pasarBDaTuplasUtil(numeroTablero: numeroTablero, tabla6: arrayCartas6, tabla10: arrayCartas10, tabla12: arrayCartas12, tabla15: arrayCartas15, tabla18: arrayCartas18, tabla21: arrayCartas21)
        
        arrayParesTuplaCartas = []
        arrayParesTuplaCartas = pasarBDpartidaAtuplasUtil(numeroTablero: numeroTablero, partida6: arrayParesPartida6, partida10: arrayParesPartida10, partida12: arrayParesPartida12, partida15: arrayParesPartida15, partida18: arrayParesPartida18, partida21: arrayParesPartida21)
    }
    
// comprobacion, animacion y final de partidas---------------------------------------------------------------------------
    func comprobarPareja(carta1: (imagen: UIImage,indice: Int), carta2: (imagen: UIImage,indice: Int)){
        
        //si el indice de alguna de las dos cartas es mayor de 1000, es que tiene la imagen por defecto.
        //si los dos indices son menores de 1000 (es decir con imagen), y son iguales es que son la misma imagen.
        if carta1.indice < 1000 && carta2.indice < 1000 && carta1.indice == carta2.indice{
            parejaHecha()
        }
        else {
            //no son pareja.
            self.perform(#selector(self.girarCarta1), with: nil, afterDelay: 1)
            self.perform(#selector(self.reproducirSonidoFallo), with: nil, afterDelay: 1)
            self.perform(#selector(self.girarCarta2), with: nil, afterDelay: 1.5)
            
            self.perform(#selector(self.finTiradaFallida), with: nil, afterDelay: 2)
        }
    }
    
    @objc func girarCarta1(){
        tiradaIniciada = !tiradaIniciada
        secuenciaGiro(cartaPulsada: self.cartaPulsada[self.indiceCartaAbierta1])
        arrayEstadoCartas[indiceCartaAbierta1] = !arrayEstadoCartas[indiceCartaAbierta1]
        CartaAgirar = indiceCartaAbierta1
    }
    
    @objc func girarCarta2(){
        secuenciaGiro(cartaPulsada: self.cartaPulsada[self.indiceCartaAbierta2])
        arrayEstadoCartas[indiceCartaAbierta2] = !arrayEstadoCartas[indiceCartaAbierta2]
        CartaAgirar = indiceCartaAbierta2
 
    }
    
   @objc func reproducirSonidoFallo(){
        reproducirSonido(sonido: playerFallo)
    }
    
    func parejaHecha(){
        reproducirSonido(sonido: playerAcierto)
        cartaPulsada[indiceCartaAbierta1].borderColor = UIColor.orange
        cartaPulsada[indiceCartaAbierta2].borderColor = UIColor.orange
        cartaPulsada[indiceCartaAbierta1].borderWidth = 8
        cartaPulsada[indiceCartaAbierta2].borderWidth = 8

        deshabilitarHabilitar(carta: self.cartaPulsada[indiceCartaAbierta1])
        deshabilitarHabilitar(carta: self.cartaPulsada[indiceCartaAbierta2])
        parejasAcertadas += 1
        self.perform(#selector(self.finTiradaAcertada), with: nil, afterDelay: 0.5)
    }
    
    @objc func finTiradaFallida(){
        comprobandoTirada = !comprobandoTirada
        indiceCartaAbierta1 = 100
        indiceCartaAbierta2 = 100
    }
    
    
    @objc func finTiradaAcertada(){
        tiradaIniciada = false
        comprobandoTirada = !comprobandoTirada
        indiceCartaAbierta1 = 100
        indiceCartaAbierta2 = 100
        if parejasAcertadas == objetivoParejasAcertadas{
        reproducirSonido(sonido: playerFinPartida)
        self.performSegue(withIdentifier: "SegueFinPartida8", sender: self)
        }
    }
    
    @objc func secuenciaGiro(cartaPulsada: UIButton){
        self.perform(#selector(cambiar), with: nil, afterDelay: 0.15)
        self.perform(#selector(estadoGirandoUnaCarta), with: nil, afterDelay: 0.35)
        
        let animationPequeñoEscalaX = CABasicAnimation(keyPath: "transform.scale.x")
        animationPequeñoEscalaX.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationPequeñoEscalaX.fromValue = 1
        animationPequeñoEscalaX.toValue = 0
        animationPequeñoEscalaX.duration = 0.15
        cartaPulsada.layer.add(animationPequeñoEscalaX, forKey: "escale animation")
        
        let animationGrandeEscalaX = CABasicAnimation(keyPath: "transform.scale.x")
        animationGrandeEscalaX.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGrandeEscalaX.fromValue = 0
        animationGrandeEscalaX.toValue = 1
        animationGrandeEscalaX.duration = 0.15
        animationGrandeEscalaX.beginTime = 0.15
        cartaPulsada.layer.add(animationGrandeEscalaX, forKey: "escale animation")
        
        let group = CAAnimationGroup()
        group.animations = [animationPequeñoEscalaX, animationGrandeEscalaX]
        group.duration = 0.3
        cartaPulsada.layer.add(group, forKey: "secuencia")
        
    }
    
    @objc func estadoGirandoUnaCarta(){
        girandoUnaCarta = false
    }
    
    @objc func cambiar(){
        let carta = self.cartaPulsada[self.CartaAgirar]
        let numeroCartaCofigurada = convertirIndiceSegunTablero(tableroJuego: numeroTablero, indiceCartaPulsada: cartaPulsada[self.CartaAgirar].tag)
        var imagen = UIImage()
        // si ya está girada se pone de nuevo boca abajo.
        if arrayEstadoCartas[CartaAgirar]{
            imagen = reverso
        }
        else{
            imagen = arrayParesTuplaCartas[numeroCartaCofigurada].imagen
        }
        
        carta.setImage(imagen, for: .normal)
        
    }
    
    //Cronometro
    @objc func actualizarCronometro(){
        tiempoTranscurrido += 1
    }
    
    func comprobarPararTimer(temporizador: Timer?){
        guard let tempUnwrapped = temporizador else{return}
        tempUnwrapped.invalidate()
    }
    
    //objetivos.
    func calcularParejasAconseguir(objetivo: [(imagen: UIImage, indice: Int)]){
        for i in objetivo{
            if i.indice < 1000{
                objetivoParejasAcertadas += 1
            }
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FinPartidaViewController {
            vc.tiempo = tiempoTranscurrido
            vc.objetivoParejasHechas = objetivoParejasAcertadas
            vc.numeroTablero = numeroTablero
        }
        
        if let vc = segue.destination as? Edit8ViewController{
            vc.numeroTableroRecibido = self.numeroTablero
        }
    }
}

