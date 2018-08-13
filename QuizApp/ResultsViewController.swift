//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Tomas Leriche on 8/12/18.
//  Copyright © 2018 Tomas Leriche. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    
    
    var responses = [Answer]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        calculatePoliticalIdentity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculatePoliticalIdentity(){
        var frequencyOfAnswers: [Difficulty: Int] = [:]
        
        let responseTypes = responses.map { $0.type }
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first?.key
        
        resultAnswerLabel.text = "You are most likely a \(mostCommonAnswer!.rawValue)!"
        
        resultDefinitionLabel.text = mostCommonAnswer?.definition
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
