//
//  RageProducts.swift
//  CursosOnline
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

//lista de compras dentro de la la app, en este caso solo hay una.
public enum RageProducts{
    
    
    //compras.
    public static let purchaseMemoryCards = "com.pablomillanlopez.juegos.CustomMemoryCards"

    //conjunto de todos los identificadores. tiene que ser un SET obligatoriamene.
    public static let productsIdentifier: Set<ProductIdentifier> = [RageProducts.purchaseMemoryCards]
    
    //referencia a IAPHelper para que compre los product identifier que hemos definido. que da acceso a la tienda de apple.
    public static let store = IAPHelper(productIdentifier: RageProducts.productsIdentifier)
    
}

