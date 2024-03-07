//
//  ViewController.swift
//  Pan
//
//  Created by Vimal Bosamiya on 07/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnActionStart(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PANCardViewController")
        self.present(vc!, animated: true)
    }
    
    
}

