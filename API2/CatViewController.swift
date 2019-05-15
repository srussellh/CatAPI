//
//  CatViewController.swift
//  API2
//
//  Created by Bobba Kadush on 5/15/19.
//  Copyright © 2019 Bobba Kadush. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {
    @IBOutlet weak var catImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CatController.shared.fetchMyCat { (cat) in
            guard let cat = cat else {return}
            CatController.shared.fetchMyCatImage(cat: cat, completion: { (image) in
                guard let image = image else {return}
                DispatchQueue.main.async {
                self.catImage.image = image
                }
            })
        }
    
    }
    @IBAction func iLoveCatsButtonPressed(_ sender: Any) {
        CatController.shared.fetchMyCat { (cat) in
            guard let cat = cat else {return}
            CatController.shared.fetchMyCatImage(cat: cat, completion: { (image) in
                guard let image = image else {return}
                DispatchQueue.main.async {
                    self.catImage.image = image
                }
            })
        }
    
    }
}
