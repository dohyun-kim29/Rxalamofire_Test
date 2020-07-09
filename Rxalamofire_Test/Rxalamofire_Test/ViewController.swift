//
//  ViewController.swift
//  Rxalamofire_Test
//
//  Created by DohyunKim on 2020/07/09.
//  Copyright © 2020 DohyunKim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let img = UIImage(named: "teoulttak")
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = img
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPost(_ sender: Any) {
    }
    
}

