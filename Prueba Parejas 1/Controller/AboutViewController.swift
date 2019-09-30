//
//  AboutViewController.swift
//  Prueba Parejas 1
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    var playerPulsacion: AVAudioPlayer!
    
    @IBAction func btnVolver(_ sender: UIButton) {
            if let soundURL = Bundle.main.url(forResource: "pulsacionBtn", withExtension: "wav"){
                
                do {
                    playerPulsacion = try AVAudioPlayer(contentsOf: soundURL)
                } catch {
                    print(error)
                }
                playerPulsacion.prepareToPlay()
            }
            reproducirSonido(sonido: playerPulsacion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
