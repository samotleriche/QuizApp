//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Tomas Leriche on 8/11/18.
//  Copyright © 2018 Tomas Leriche. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multilabel1: UILabel!
    @IBOutlet weak var multilabel2: UILabel!
    @IBOutlet weak var multilabel3: UILabel!
    @IBOutlet weak var multilabel4: UILabel!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedlabel1: UILabel!
    @IBOutlet weak var rangedlabel2: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multiAnswerSubmitButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedAnswerSlider: UISlider!
    
    @IBAction func rangedAnswerButtonPressed(){
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(rangedAnswerSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    var answersChosen: [Answer] = []
    
    var questionIndex = 0
    
    var questions: [Question] = [
        Question(text: "Are you pro-life or pro-choice?",
                 type: .single,
                 answers: [
                    Answer(text: "pro-life!!", type: .advanced),
                    Answer(text: "maybe pro-life", type: .hard),
                    Answer(text: "perhaps pro-choice", type: .medium),
                    Answer(text: "pro-choice!!", type: .easy)
            ]),
        Question(text: "Which activities do you enjoy?", type: .multiple, answers: [Answer(text: "Hunting", type: .advanced),Answer(text: "Fishing", type: .hard), Answer(text: "Scrabble", type: .medium), Answer(text: "protesting abortion", type: .easy)]),
        
        Question(text: "How much do you enjoy \"Last Week Tonight\"?", type: .ranged, answers: [Answer(text: "I hate it", type: .advanced), Answer(text: "It's not my favorite show", type: .hard), Answer(text: "It's alright, pretty funny sometimes", type: .medium), Answer(text: "Its the best thing on television", type: .easy)])
    ]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex)/Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updatedSingleStack(using: currentAnswers)
        case .multiple:
            updatedMultiStack(using: currentAnswers)
        case .ranged:
            updatedRangedStack(using: currentAnswers)
        }
    }

    func updatedSingleStack(using answers: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updatedMultiStack(using answers: [Answer]){
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multilabel1.text = answers[0].text
        multilabel2.text = answers[1].text
        multilabel3.text = answers[2].text
        multilabel4.text = answers[3].text
    }
    
    func updatedRangedStack(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedAnswerSlider.setValue(0.5, animated: false)
        rangedlabel1.text = answers.first?.text
        rangedlabel2.text = answers.last?.text
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        }else{
            performSegue(withIdentifier: "resultSeg", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSeg" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }

}
