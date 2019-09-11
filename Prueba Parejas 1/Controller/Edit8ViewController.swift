//
//  Edit8ViewController.swift
//  Prueba Parejas 1
//
//  Created by admin on 31/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import GoogleMobileAds

class Edit8ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, GADInterstitialDelegate {
    
    var numeroTableroRecibido = 0
    var arrayTuplaCartas = [(imagen: UIImage,indice: Int)]()

   
    var arrayCartas6 = [GaleriaFotos6]()
    var arrayCartas10 = [GaleriaFotos10]()
    var arrayCartas12 = [GaleriaFotos12]()
    var arrayCartas15 = [GaleriaFotos15]()
    var arrayCartas18 = [GaleriaFotos18]()
    var arrayCartas21 = [GaleriaFotos21]()
    
    let factoriaCartas = FactoriaImagenes()
    var fotoSeleccionada: UIImage?
    var indiceCartaAcambiar = 0
    var imagenPorDefecto: UIImage?

    var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")

    @IBOutlet weak var collectionViewCartas: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.collectionViewCartas.delegate = self
        self.collectionViewCartas.dataSource = self
        
        numeroTableroRecibido /= 2
        leerBDcorrespondiente()
        
        guard let imgDefault = UIImage(named: "imagenPorDefecto") else {return}
        imagenPorDefecto = imgDefault
        
        self.interstitial = createAndLoadInterstitial()
        mostrarBannerInt()
        
    }
    
    
    //MARK: bloque lectura base de datos
    func leerBDcorrespondiente(){
        //generar array del tipo del Entity del coredata corespondiente y el array con todas las cartas en orden aleatorio y del mismo tipo.
        switch numeroTableroRecibido {
        case 6:
            arrayCartas6 = [GaleriaFotos6]()
            arrayCartas6 = factoriaCartas.leerGaleria6Parejas()
            if arrayCartas6.isEmpty{
                factoriaCartas.crearImagenesPorDefecto6Parejas()
                arrayCartas6 = factoriaCartas.leerGaleria6Parejas()
            }

        case 10:
            arrayCartas10 = [GaleriaFotos10]()
            arrayCartas10 = factoriaCartas.leerGaleria10Parejas()
            if arrayCartas10.isEmpty{
                factoriaCartas.crearImagenesPorDefecto10Parejas()
                arrayCartas10 = factoriaCartas.leerGaleria10Parejas()
            }

        default:
            print("no se ha creado parejas aleatorias.")
        }
        
        //pasar los array en tuplas.
        arrayTuplaCartas = []
        arrayTuplaCartas = pasarBDaTuplasUtil(numeroTablero: (numeroTableroRecibido*2), tabla6: arrayCartas6, tabla10: arrayCartas10, tabla12: arrayCartas12, tabla15: arrayCartas15, tabla18: arrayCartas18, tabla21: arrayCartas21)
    }
    
    //MARK: bloque metodos collectionView.
    //detecta cambio de orientacion pantalla
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        //recarga las celdas pero no los datos, asi calcula de nuevo el tamaño de las celdas al girar el dispositivo.
        print("cambio")
        collectionViewCartas.collectionViewLayout.invalidateLayout()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTuplaCartas.count
    }

    //calcular tamaño celda.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       //si el dispositivo es un iphone
        if UIDevice.current.userInterfaceIdiom == .phone{
             return CGSize(width: view.frame.size.width/4.0, height: view.frame.size.width/4.0)
            }
        //si el dispositivo es un ipad
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: view.frame.size.width/5.0, height: view.frame.size.width/5.0)
        }
        
        // To get 1 column
        return CGSize(width: view.frame.size.width, height: view.frame.size.width)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 5.0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 30.0 }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartasCell", for: indexPath) as? CeldaCartasCollectionViewCell
        let carta = arrayTuplaCartas[indexPath.row]
        let imagenCarta = carta.imagen
        cell?.imageViewCarta.image = imagenCarta
        cell?.imageViewCarta.contentMode = .scaleToFill
        cell?.backgroundColor = UIColor.red
        cell?.outletBtnImgDefecto.tag = indexPath.row
        cell?.outletBtnImgDefecto.addTarget(self, action: #selector(btnDefecto(_:)), for: .touchUpInside)
        cell?.labelEditCell.text = "Pair Nº \(indexPath.row + 1)"
        if carta.indice < 1000{
            cell?.labelNoPhoto.isHidden = true
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        indiceCartaAcambiar = indexPath.row
        present(picker,animated: true)
    }

    //MARK: bloque metodos imagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //comprobar si hay foto
        guard let foto = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{return}
        
        self.fotoSeleccionada = resizeImage(image: foto)
        
        switch numeroTableroRecibido {
        case 6:
            factoriaCartas.cambiarCarta(carta: fotoSeleccionada!, indice: indiceCartaAcambiar, porDefecto: false, arrayBD: arrayCartas6)
        case 10:
            factoriaCartas.cambiarCarta(carta: fotoSeleccionada!, indice: indiceCartaAcambiar, porDefecto: false, arrayBD: arrayCartas10)
        default:
            print("no hay para cambiar")
        }

        dismiss(animated: true) {
            self.leerBDcorrespondiente()
            self.collectionViewCartas.reloadData()
           
        }
    }
    
    //funcion en caso de que el usuario cancele la accion del picker.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        dismiss(animated: true, completion: nil)
    }
    
    //MARK: bloque boton por defecto.
    @IBAction func btnDefecto (_ sender: UIButton){
        
        switch numeroTableroRecibido {
        case 6:
            factoriaCartas.cambiarCarta(carta: imagenPorDefecto!, indice: sender.tag, porDefecto: true, arrayBD: arrayCartas6)
        case 10:
            factoriaCartas.cambiarCarta(carta: imagenPorDefecto!, indice: sender.tag, porDefecto: true, arrayBD: arrayCartas10)
        case 12:
            factoriaCartas.cambiarCarta(carta: imagenPorDefecto!, indice: sender.tag, porDefecto: true, arrayBD: arrayCartas12)
        case 15:
            factoriaCartas.cambiarCarta(carta: imagenPorDefecto!, indice: sender.tag, porDefecto: true, arrayBD: arrayCartas15)
        case 18:
            factoriaCartas.cambiarCarta(carta: imagenPorDefecto!, indice: sender.tag, porDefecto: true, arrayBD: arrayCartas18)
        case 21:
            factoriaCartas.cambiarCarta(carta: imagenPorDefecto!, indice: sender.tag, porDefecto: true, arrayBD: arrayCartas21)
        default:
            print("no hay para cambiar por defecto")
        }

        self.leerBDcorrespondiente()
        self.collectionViewCartas.reloadData()

    }
  
    //MARK: bloque importar imagenes de otros tableros
    @IBAction func btnImportar(_ sender: UIButton) {
        let alert = UIAlertController(title: "IMPORT IMAGES FROM OTHER BOARDS", message: "SELECT A BOARD TO IMPORT IMAGES", preferredStyle: .actionSheet)
        let actionBoard12 = UIAlertAction(title: "BOARD 12", style: .default) { (UIAlertAction) in
            self.importarImagenes(tableroOrigen: 6)
        }
        let actionBoard20 = UIAlertAction(title: "BOARD 20", style: .default, handler: { action in
            self.importarImagenes(tableroOrigen: 10)
        })
        let actionBoard24 = UIAlertAction(title: "BOARD 24", style: .default, handler: { action in
            self.importarImagenes(tableroOrigen: 12)
        })
        let actionBoard30 = UIAlertAction(title: "BOARD 30", style: .default, handler: { action in
            self.importarImagenes(tableroOrigen: 15)
        })
        let actionBoard36 = UIAlertAction(title: "BOARD 36", style: .default, handler: { action in
            self.importarImagenes(tableroOrigen: 18)
        })
        let actionBoard42 = UIAlertAction(title: "BOARD 42", style: .default, handler: { action in
            self.importarImagenes(tableroOrigen: 21)
        })
        
        let actionCancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
            return
        })
        
        
        //el condicional evita que se muestre el tablero actual como posible tablero de origen para importar las imagenes.
        if !(actionBoard12.title?.contains(String(numeroTableroRecibido*2)))!{
            alert.addAction(actionBoard12)
        }
        if !(actionBoard20.title?.contains(String(numeroTableroRecibido*2)))!{
            alert.addAction(actionBoard20)
        }
        if !(actionBoard24.title?.contains(String(numeroTableroRecibido*2)))!{
            alert.addAction(actionBoard24)
        }
        if !(actionBoard30.title?.contains(String(numeroTableroRecibido*2)))!{
            alert.addAction(actionBoard30)
        }
        if !(actionBoard36.title?.contains(String(numeroTableroRecibido*2)))!{
            alert.addAction(actionBoard36)
        }
        if !(actionBoard42.title?.contains(String(numeroTableroRecibido*2)))!{
            alert.addAction(actionBoard42)
        }
        
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
    
    func importarImagenes(tableroOrigen: Int){
        var imagen = UIImage()
        //tablero origen es el tablero desde el que se va a importar las imagenes.
        switch tableroOrigen {
        case 6:
            //carga un array con la base de datos origen.
            var arrayCartas6 = factoriaCartas.leerGaleria6Parejas()
            //en el bucle, obtiene la imagen de la base de datos origen y llama a la funcion cambiarImagenImportada.
            for i in 0...(tableroOrigen - 1){
                let porDefecto = arrayCartas6[i].indice >= 1000 ? true : false
                imagen =  UIImage(data: arrayCartas6[i].imagen!)!
                cambiarImagenimportada(imagen: imagen, indice: i, porDefecto: porDefecto )
            }
            //vacia el array de la base de datos origen porque ya no se va a usar.
            arrayCartas6 = []
            
        case 10:
            var arrayCartas10 = factoriaCartas.leerGaleria10Parejas()
            for i in 0...(tableroOrigen - 1){
                let porDefecto = arrayCartas10[i].indice >= 1000 ? true : false
                imagen = UIImage(data: arrayCartas10[i].imagen!)!
                cambiarImagenimportada(imagen: imagen, indice: i, porDefecto: porDefecto )
            }
            arrayCartas10 = []
        default:
            print("no se ha creado parejas aleatorias.")
        }
    }
    
    func cambiarImagenimportada(imagen: UIImage, indice: Int, porDefecto: Bool){

        switch numeroTableroRecibido {
        case 6:
            //si la imagen es la imagen por defecto no se tiene que cambiar
            //y si el indice es mayor que el numero de cartas del tablero actual tampoco.
            if  !porDefecto && indice < numeroTableroRecibido{
            factoriaCartas.cambiarCarta(carta: imagen, indice: indice, porDefecto: false, arrayBD: arrayCartas6)
            }
            else{return}
        case 10:
            if !porDefecto && indice < numeroTableroRecibido{
                factoriaCartas.cambiarCarta(carta: imagen, indice: indice, porDefecto: false, arrayBD: arrayCartas10)
            }
            else{return}
        default:
            
            print("sin carta a cambiar")
        }
        
        self.leerBDcorrespondiente()
        self.collectionViewCartas.reloadData()
    }
    
    //MARK: bloque interstitial
    @objc func mostrarBannerInt(){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
            self.perform(#selector(self.mostrarBannerInt), with: nil, afterDelay: 0.5)
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        let request = GADRequest()
        request.testDevices = [ "fdc54c9b833a5ec8efe5071e24a13cab" ]
        interstitial.load(request)
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = createAndLoadInterstitial()
    }
    
    //MARK: bloque pasar informacion entre viewcontrollers.
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BoardViewController {
            vc.numeroTablero = numeroTableroRecibido*2
        }
        
    }

}
