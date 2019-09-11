//
//  Extensions.swift
//  Prueba Parejas 1
//
//  Created by admin on 31/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat{
        set{
            layer.borderWidth = newValue
        }
        get{
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat{
        
        set{
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
        
    }
    
    @IBInspectable var borderColor: UIColor?{
        
        set{
            guard let uiColor = newValue else {return}
            layer.borderColor = uiColor.cgColor
        }
        get{
            guard let color = layer.borderColor else{return nil}
            return UIColor(cgColor: color)
        }
        
    }
    
    @IBInspectable var shadowColor: UIColor?{
        set{
            guard let uiColor = newValue else {return}
            layer.shadowColor = uiColor.cgColor
        }
        
        get{
            guard let color = layer.shadowColor else {return nil}
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadoeOffset: CGSize{
        set{
            layer.shadowOffset = newValue

        }
        
        get{
            return layer.shadowOffset
        }
    }
   
    @IBInspectable var shadowOffset: CGSize{
        set{
            layer.shadowOffset = newValue
            
        }
        
        get{
            return layer.shadowOffset
        }
    }
    
    
    @IBInspectable var shadowRadius: CGFloat{
        
        set{
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
        
    }
    
    @IBInspectable var shadowOpacity: Float{
        
        set{
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
        
    }
}
