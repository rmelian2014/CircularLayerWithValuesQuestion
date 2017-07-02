//
//  ViewController.swift
//  CircularLayerWithValuesQuestion
//
//  Created by Reinier Melian on 01/07/2017.
//  Copyright © 2017 Pruebas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circlesView: CirclesView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAction(_ sender: Any) {
        
        self.circlesView.animateToAngle(angle: CGFloat((self.circlesView.valueCircle?.amountOfDegreeValue)! + 270))
    }

}

