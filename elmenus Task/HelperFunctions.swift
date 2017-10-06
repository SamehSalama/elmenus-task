//
//  HelperFunctions.swift
//  elmenus Task
//
//  Created by Sameh Salama on 10/6/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import Foundation
import UIKit

class HelperFunctions {

    class func alertWithSingleAction(presentingViewController:UIViewController, alertTitle:String, alertMessage:String, actionTitle:String, actionHandler:((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: actionHandler)
        alert.addAction(action)
        presentingViewController.present(alert, animated: true, completion: nil)
    }

}
