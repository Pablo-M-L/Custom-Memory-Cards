//
//  ViewController.swift
//  Prueba Parejas 1
//
//  Created by admin on 31/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import AVFoundation
import StoreKit
import GoogleMobileAds


class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
  
    //storekit
    //notificacion que se generará cuando el producto se haya comprado o restaurado correctamente.
    public let IAPHelperProductPurchasedNotification = "kIAPHelperProductPurchasedNotification"
    var purchase = [SKProduct]()
    lazy var priceFormatter: NumberFormatter = {
        let pf = NumberFormatter()
        pf.formatterBehavior = .behavior10_4
        pf.numberStyle = .currency
        return pf
    }()
    var precioCompra = String()
    var defaults = UserDefaults.standard
    var appComprada = false
    var timer = Timer()
    
    
    
    //facebook
    let shareButton: FBShareButton = {
        let button = FBShareButton()
        let content = ShareLinkContent()
        content.contentURL = NSURL(string:"https://apps.apple.com/es/app/memoria-juego-parejas-cartas/id1479676748")! as URL
        button.shareContent = content
        button.setTitle("", for: .normal)
        button.setTitle("", for: .highlighted)
        button.setImage(UIImage(named: "iconoTransparenteParaFacebook"), for: .normal)
        button.setImage(UIImage(named: "iconoTransparenteParaFacebook"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "iconoTransparenteParaFacebook"), for: .normal)
        button.setBackgroundImage(UIImage(named: "iconoTransparenteParaFacebook"), for: .highlighted)
        button.addTarget(self, action: #selector(reproduc), for: .touchUpInside)
        
        return button
    }()
    
    //juego
    var tableroAjugar = 0
    var playerPulsacion: AVAudioPlayer!
    var playerPulsacion2: AVAudioPlayer!

    
    
    @IBOutlet weak var bannerView: GADBannerView!
    let requestConfiguration = GADMobileAds.sharedInstance().requestConfiguration
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBAction func btnFacebookPresed(_ sender: UIButton) {
        reproducirSonido(sonido: playerPulsacion2)
    }
    
    @IBAction func btnAbout(_ sender: UIButton) {
        reproducirSonido(sonido: playerPulsacion)
    }
    
    @IBAction func btnInstruciones(_ sender: UIButton) {
        reproducirSonido(sonido: playerPulsacion)
    }
    var estado = true
    var imagen = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        //copmprobar primer juego
        let mostrarAvisoprimerjuego = defaults.bool(forKey: "primerjuego")
        if !mostrarAvisoprimerjuego{
            let alert = UIAlertController(title: NSLocalizedString("titulo-alert-primerJuego", comment: ""), message: NSLocalizedString("mensaje-alert-primerJuego", comment: ""), preferredStyle: .alert)
            let actionOk = UIAlertAction(title: NSLocalizedString("boton-alert-primerJuego", comment: ""), style: .default, handler: {
                action in
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "primerjuego")
                defaults.synchronize()
                self.performSegue(withIdentifier: "segueMenuToInstrucciones", sender: nil)
                
                
            })
            alert.addAction(actionOk)
            present(alert,animated: true)
        }
        
        if let soundURL = Bundle.main.url(forResource: "pulsacionBtn", withExtension: "wav"),
           let soundURL2 = Bundle.main.url(forResource: "pulsacionBtn2", withExtension: "wav"){
            
            do {
                playerPulsacion = try AVAudioPlayer(contentsOf: soundURL)
                playerPulsacion2 = try AVAudioPlayer(contentsOf: soundURL2)
            } catch {
                print(error)
            }
            playerPulsacion.prepareToPlay()
            playerPulsacion2.prepareToPlay()
        }

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //comprobar si hay que mostrar publicidad o está comprada.
        appComprada = defaults.bool(forKey: "com.pablomillanlopez.juegos.CustomMemoryCards")
        if appComprada{
            hideAdmobBanner()
        }
        else{
            leerADs()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(recargarViewcontroller), name: NSNotification.Name(rawValue: IAPHelperProductPurchasedNotification), object: nil)
        
        
        //boton facebook.
        self.btnFacebook.addSubview(shareButton)
        shareButton.center = CGPoint(x: 30, y: 35)
        shareButton.bounds.size.width = self.btnFacebook.frame.width
        shareButton.bounds.size.height = self.btnFacebook.frame.height
        
    }
    
    @objc func reproduc(){
        reproducirSonido(sonido: playerPulsacion2)
    }
    @objc func recargarViewcontroller(){
        self.viewDidLoad()
    }
    

    //MARK: publicidad y compras.

    func leerADs(){
        //indica que se muestren anuncios de contenido adaptado a niños.
        GADMobileAds.sharedInstance().requestConfiguration.tag(forChildDirectedTreatment: true)
        //inicializa el SDK. solo se hace una vez.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        //crear anuncio
        self.bannerView.adUnitID = "ca-app-pub-4831265414200206/8871267675"
        self.bannerView.rootViewController = self
        //carga anuncios
        self.bannerView.load(GADRequest())
        showAdmobBanner()
    }
    
    func showAdmobBanner(){
        self.bannerView.isHidden = false
    }
    
    func hideAdmobBanner(){
        self.bannerView.isHidden = true
    }
    
    @IBAction func btnCompraApp(_ sender: UIButton) {
        reproducirSonido(sonido: playerPulsacion2)
        if appComprada{
            let alert = UIAlertController(title: NSLocalizedString("titulo_alert_compra", comment: ""), message: NSLocalizedString("mensaje_alert_comprada", comment: ""), preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .default, handler: {action in return})
            alert.addAction(actionOk)
            present(alert, animated: true)
            }
            //antes de solicitar la compra hay que comprobar si la app está comprada en itunes pero no consta en defaults,
            //para restaurar compra si es el caso .
        else if !appComprada{
            obtenerListaCompra()
            }
 
    }
    
    //obtiene la lista de compras hechas para saber si ya estaba comprada.
    func obtenerListaCompra(){
        RageProducts.store.requestProductsWithCompletionHandler { (success, purchase) in
            if success{
                //se le pasa a la variable purchase el resultado de la consulta.
                self.purchase = purchase
                //precio de la compra para quitar la publicidad en el formato de la moneda local.
                self.priceFormatter.locale = self.purchase[0].priceLocale
                //pasarlo a string
                self.precioCompra = self.priceFormatter.string(from: purchase[0].price)!
                self.comprobarRestaurarCompra()
            }
            
        }
        
    }
    
    //si en defautl no consta ninguna compra, hay que comprobar si en itunnes la compra está hecha y si lo está, restaurarla.
    func comprobarRestaurarCompra(){
        //si se reinstala la app, el defaults y el purchasedProductIdentefier estan en false.
        //por eso se llama a la funcion restoreCompleteTransition para restaurar compra (si la hay)
        //se añade retraso porque tarda restaurar la compra y muestra la pantalla de compra antes de que restaure la compra y cambie el valor de defaults o purchased...
        
        RageProducts.store.restoreCompletedTransactions()

        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
            if RageProducts.store.hasPurchaseProduct(productIdentifier: self.purchase[0].productIdentifier){
                
                let alert = UIAlertController(title: NSLocalizedString("titulo_alert_compra", comment: ""), message: NSLocalizedString("mensaje_alert_restaurar", comment: ""), preferredStyle: .alert)
                
                let actionOk = UIAlertAction(title: "OK", style: .default, handler: {action in self.restaurarCompras()})
                let actionCancel = UIAlertAction(title: NSLocalizedString("btnCancelar", comment: ""), style: .default, handler: {action in return})
                alert.addAction(actionOk)
                alert.addAction(actionCancel)
                self.present(alert, animated: true)
            }
                //si no hay compra, se le comunica al usuario si quiere proceder a comprar la app.
                //comprobando antes si la compra está permitida. (control parental)
            else{
                if IAPHelper.canMakePayment(){
                    //se añade la opcion de restaurar por si en una reinstalacion con la compra hecha, el retraso anterior no es suficiente para comprobar si hay compra.
                    //si se pulsa en restaurar pero no hay compra vuelve a salir en mismo alert.
                    let alert = UIAlertController(title: NSLocalizedString("titulo_alert_compra", comment: ""), message: "\(NSLocalizedString("mensaje_alert_comprar_app", comment: "")) \(self.precioCompra)", preferredStyle: .alert)
                    
                    let actionOk = UIAlertAction(title: NSLocalizedString("btnComprar", comment: ""), style: .default, handler: {action in self.comprarApp()})
                    let actionRestaurar = UIAlertAction(title: NSLocalizedString("btnRestaurar", comment: ""), style: .default, handler: {action in self.comprobarRestaurarCompra()})
                    let actionCancel = UIAlertAction(title: NSLocalizedString("btnCancelar", comment: ""), style: .default, handler: {action in return})
                    alert.addAction(actionOk)
                    alert.addAction(actionRestaurar)
                    alert.addAction(actionCancel)
                    
                    self.present(alert, animated: true)
                }
                else{
                    let alert = UIAlertController(title: NSLocalizedString("titulo_alert_compra", comment: ""), message: NSLocalizedString("mensaje_alert_no_permiso_compra", comment: ""), preferredStyle: .alert)
                    let actionOk = UIAlertAction(title: "OK", style: .default, handler: {action in return})
                    alert.addAction(actionOk)
                    self.present(alert, animated: true)
                }
                
            }
        })

    }

    
    func comprarApp(){
        RageProducts.store.purchaseProduct(product: purchase[0])
    }
    
    func restaurarCompras(){
        print("vamos a restaurar la compra")
        RageProducts.store.restoreCompletedTransactions()
    }
    

    //MARK: collectionview.
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuPrincipalCell", for: indexPath) as? CeldasMenuPrincipal
        //let numeroCartas = ["12","20","24","30","36","42"]
        let numeroImagen = ["num12","num20","num24","num30","num36","num42"]
        cell?.labelCeldaMenu.text = "" //\(numeroCartas[indexPath.row]) Cards"
        cell?.imagenCeldaMenu.image = UIImage(named: numeroImagen[indexPath.row])
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        reproducirSonido(sonido: playerPulsacion)
        switch indexPath.row {
        case 0:
            tableroAjugar = 12
        case 1:
            tableroAjugar = 20
        case 2:
            tableroAjugar = 24
        case 3:
            tableroAjugar = 30
        case 4:
            tableroAjugar = 36
        case 5:
            tableroAjugar = 42
        default:
            print("fallo de tablero")
        }
        self.performSegue(withIdentifier: "segueShowCards", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //si el dispositivo es un iphone
        if UIDevice.current.userInterfaceIdiom == .phone{
                //divide el tamaño de la vista collectionView
                return CGSize(width: view.frame.size.width/3.4, height: view.frame.size.width/3.4)// dos celdas
            
            
        }
        //si el dispositivo es un ipad
        if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: view.frame.size.width/4.0, height: view.frame.size.width/4.0)
            }
        
        return CGSize(width: view.frame.size.width/4.0, height: view.frame.size.width/4.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 10.0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 1.0 }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? BoardViewController{
            vc.numeroTablero = tableroAjugar
        }
    }
}

