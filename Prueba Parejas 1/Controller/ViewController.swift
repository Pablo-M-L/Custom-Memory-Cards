//
//  ViewController.swift
//  Prueba Parejas 1
//
//  Created by admin on 31/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import GoogleMobileAds


class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
  
    var tableroAjugar = 0

    let shareButton: FBSDKShareButton = {
        let button = FBSDKShareButton()
        let content = FBSDKShareLinkContent()
        content.contentURL = NSURL(string:"https://apps.apple.com/es/app/super-mario-run/id1145275343") as URL?
        button.shareContent = content
        button.setTitle("", for: .normal)
        button.setTitle("", for: .highlighted)
        button.setImage(UIImage(named: ""), for: .normal)
        button.setImage(UIImage(named: ""), for: .highlighted)
        button.setBackgroundImage(UIImage(named: ""), for: .normal)
        button.setBackgroundImage(UIImage(named: ""), for: .highlighted)
        
        //button.center = CGPoint(x: 30, y: 30)

        return button
    }()
    
    
    @IBOutlet weak var bannerView: GADBannerView!

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBOutlet weak var btnAbout: UIButton!
    
    var estado = true
    var imagen = UIImage()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        leerADs()
        
        self.btnFacebook.addSubview(shareButton)
        shareButton.center = CGPoint(x: 30, y: 35)
        shareButton.bounds.size.width = self.btnFacebook.frame.width
        shareButton.bounds.size.height = self.btnFacebook.frame.height
    }
    
    func leerADs(){
        self.bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
        //test
        let request = GADRequest()
        request.testDevices = [ "fdc54c9b833a5ec8efe5071e24a13cab" ]
        self.bannerView.load(request)
        showAdmobBanner()
    }
    
    func showAdmobBanner(){
        self.bannerView.isHidden = false
    }
    
    func hideAdmobBanner(){
        self.bannerView.isHidden = true
    }
    
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

