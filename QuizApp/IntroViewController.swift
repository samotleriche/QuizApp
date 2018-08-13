//
//  ViewController.swift
//  QuizApp
//
//  Created by Tomas Leriche on 8/11/18.
//  Copyright © 2018 Tomas Leriche. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var pastResult: UILabel!
    
    var dataRecieved: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToQuizIntroduciton(segue: UIStoryboardSegue){
        if let resultViewController = segue.source as? ResultsViewController {
            pastResult.text = "Last result: " + resultViewController.resultAnswerLabel.text!
    }
    
}
}
