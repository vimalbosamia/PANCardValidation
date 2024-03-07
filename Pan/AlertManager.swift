//
//  AlertManager.swift
//  Pan
//
//  Created by Vimal Bosamiya on 07/03/24.
//

import UIKit

class AlertManager {
    
    static func showAlert(on viewController: UIViewController, withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            viewController.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }

}
