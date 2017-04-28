//
//  BLUtilities.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/17.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLUtilities: NSObject {
    
    class func loadViewControllerFromMainStoryboard(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    //Show prompt alert with OK button
    class func showAlert(_ title: String, message: String = "", okName: String = REX_STRING_OK, inViewController: UIViewController?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: okName, style: UIAlertActionStyle.default, handler: nil))
        if inViewController != nil {
            DispatchQueue.main.async(execute: {
                inViewController!.present(alertView, animated: true, completion: nil)
            })
        }
    }
    
    class func showAlert2(_ title: String, message: String = "", okName: String = REX_STRING_OK, inViewController: UIViewController?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: okName, style: UIAlertActionStyle.default, handler: nil))
        if inViewController != nil {
            DispatchQueue.main.async(execute: {
                inViewController!.present(alertView, animated: true, completion: nil)
            })
        }
    }
    
    //Show prompt alert with OK button and call back
    
    class func showOKAlert(_ title: String, message: String, rightName: String = REX_STRING_OK, inViewController: UIViewController?,completion: @escaping (_ result:Bool) -> ()) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: rightName, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            
            completion(true)
            
        }))
        if inViewController != nil {
            DispatchQueue.main.async(execute: {
                inViewController!.present(alertView, animated: true, completion: { () -> Void in
                })
            })
        }
    }
    
    
    //Show prompt alert with OK and Cancel button
    
    class func showAlert(_ title: String, message: String,  rightName: String = REX_STRING_OK, inViewController: UIViewController, completion: @escaping (_ result:Bool) -> ()) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertView.addAction(UIAlertAction(title: REX_STRING_CANCEL, style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction!) in
            completion(false)
        }))
        
        alertView.addAction(UIAlertAction(title: rightName, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            completion(true)
            
        }))
        DispatchQueue.main.async {
            inViewController.present(alertView, animated: true, completion: nil)
        }
    }
    
    class func showAlert(_ title: String, message: String,leftName: String, rightName: String, inViewController: UIViewController, completion: @escaping (_ result:Bool) -> ()) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertView.addAction(UIAlertAction(title: leftName, style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction!) in
            completion(false)
        }))
        
        alertView.addAction(UIAlertAction(title: rightName, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            completion(true)
            
        }))
        DispatchQueue.main.async {
            inViewController.present(alertView, animated: true, completion: nil)
        }
    }

}
