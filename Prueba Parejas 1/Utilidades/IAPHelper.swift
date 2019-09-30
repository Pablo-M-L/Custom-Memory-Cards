//
//  IAPHelper.swift
//  CursosOnline
//
//  Created by admin on 13/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import StoreKit

//notificacion que se generará cuando el producto se haya comprado correctamente.
public let IAPHelperProductPurchasedNotification = "kIAPHelperProductPurchasedNotification"

//los product identifier son los string unicos registrados en la app store
public typealias ProductIdentifier = String

public typealias RequestProductsCompletionHandler = (_ succes: Bool, _ products:[SKProduct]) -> ()

// la clase helper nos ayudará con las compras, haciendo una peticion y recepcion de los productos disponibles,
//si ya los tenemos comprados o no, los comprará, e incluso restaurará las compras.
//sabremos si un producto o no se ha comprado, utilizando la clase NSUserDefaults.
public class IAPHelper: NSObject{
    //variables para tener control de los productos y cuales han sido comprado. en este caso solo hay un producto.
    private let productIdentifier: Set<ProductIdentifier> //conjunto de productos (compras)
    private var purchaseProductsIdentifiers = Set<ProductIdentifier>() //conjunto de productos comprados.
    
    //variables para el delegado de las compras.
    private var productsRequestVar: SKProductsRequest? //peticion de productos.
    private var completionHandler: RequestProductsCompletionHandler?
    
    //inicializador de IAPHelper, que pedirá a apple las compras disponibles a partir de un conjunto de identificacores.
    public init(productIdentifier: Set<ProductIdentifier>){
    
        self.productIdentifier = productIdentifier //nombre del id de la compra.
        //guarda en userdefaults si los cursos ya se han comprado o no.
        let defaults = UserDefaults.standard
        for productID in self.productIdentifier{
            let purchased = defaults.bool(forKey: productID)
            if purchased{
                purchaseProductsIdentifiers.insert(productID)
            }
        }
        
        super.init()
        //observador de las compras
        SKPaymentQueue.default().add(self)
    }
    
    //obtiene una lista de skproducts del servidor de apple y llama al completionhandler  declarado antes
    public func requestProductsWithCompletionHandler(handler: @escaping RequestProductsCompletionHandler){
        productsRequestVar?.cancel()
        completionHandler = handler
        productsRequestVar = SKProductsRequest(productIdentifiers: productIdentifier) //hace la peticion del producto.
        productsRequestVar?.delegate = self
        productsRequestVar?.start() //pide los productos.

    }
    
    //le pasamos un skproduct y hace la compra del mismo.
    public func purchaseProduct(product: SKProduct){
        let payment = SKPayment(product: product) //crea un pago
        SKPaymentQueue.default().add(payment) //añadimos a la cola de pagos el pago del producto.
    }
    
    
    //metodo que, dado un ID de producto, nos dice si se ha comprado o no.
    public func hasPurchaseProduct(productIdentifier: ProductIdentifier) -> Bool{
        return purchaseProductsIdentifiers.contains(productIdentifier)
    }
    
    
    //control parental
    public class func canMakePayment() ->Bool{
        return SKPaymentQueue.canMakePayments()
    }
    
    // si hemos perdido alguna de las compras (ej. el usuario borra la app, y la reinstala mas adelante,
    //o bien la hemos hecho en otro dispositivo, restauraremos las compras.
    public func restoreCompletedTransactions(){
                print("restaurando")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}

//esxtension como delegado de consultas.  pide la lista de productos a apple.
extension IAPHelper: SKProductsRequestDelegate{

    //metodo que se ejecuta cuando las peticiones se finalizan satisfactoriamente.
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        completionHandler?( true, products)
        clearRequest()
        for p in products{
            print("tenemos el producto \(p.productIdentifier) a un precio de \(p.price.floatValue)")
            
        }
    }
    
    //metodo que se ejecuta cuando hay un error.
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("no se ha podido recuperar el producto por el error: \(error.localizedDescription)")
        clearRequest()
    }
    
    //limpiar las variables de la peticion.
    private func clearRequest(){
        productsRequestVar = nil
        completionHandler = nil
    }
}

//extension como delegado de pagos/compras. observador de compras.
extension IAPHelper: SKPaymentTransactionObserver{
    //se ejecuta cuando algunas de las trasacciones cambia de estado.
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("observando")
        for transaction in transactions {
            switch(transaction.transactionState){
            case .purchased:
                completeTransaction(transaction: transaction)
                break
            case .failed:
                failedTransaction(transaction: transaction)
                break
            case .restored:
                restoreTransaction(transaction: transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            default:
                break
            }
        }
    }
    
    //transaccion completada.
    private func completeTransaction(transaction: SKPaymentTransaction){
        provideContentForProductID(productIdentifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction) //cierra la transaccion.
        
    }
    
    private func restoreTransaction(transaction: SKPaymentTransaction){
        let productID = transaction.original?.payment.productIdentifier
        provideContentForProductID(productIdentifier: productID!)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func failedTransaction(transaction: SKPaymentTransaction){
        if transaction.error?.localizedDescription != "paymentCancelled"{
            print("transaction error: \((transaction.error?.localizedDescription)!)")
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    //guarda en el userDefaults si ya esta comprado.
    private func provideContentForProductID(productIdentifier: ProductIdentifier){
        self.purchaseProductsIdentifiers.insert(productIdentifier)
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: productIdentifier)
        defaults.synchronize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: IAPHelperProductPurchasedNotification), object: productIdentifier)
    }
    

}
