//
//  QuestionData.swift
//  QuizApp
//
//  Created by Tomas Leriche on 8/12/18.
//  Copyright © 2018 Tomas Leriche. All rights reserved.
//

import Foundation


struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: Difficulty
}

enum Difficulty: String {
    case easy = "basic vocabulary", medium = "good vocabulary", hard = "college level", advanced = "graduate level"
    
    var definition: String {
        switch self {
        case .easy:
            return "You have a basic vocabulary, keep learning to advance your skills"
        case .medium:
            return "You have a generally good vocabulary, more practice would improve your reading comprehension and stardardized test scores"
        case .hard:
            return "You have a college level vocabulary, you could keep refining your skills to do even better on standardized tests like the GRE, GMAT, LSAT or MCAT"
        case .advanced:
            return "You have an impressive vocabulary, keep the knowledge fresh in your mind before you take a big standadized test."
        }
    }
    
}


