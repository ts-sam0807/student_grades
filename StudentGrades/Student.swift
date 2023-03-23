//
//  Student.swift
//  StudentGrades
//
//  Created by Ts SaM on 23/3/2023.
//

import Foundation

class Student {
  private(set) var firstName: String
  private(set) var lastName: String
  private(set) var scores: [Int]
  
  init(firstName: String, lastName: String, scores: [Int]) {
    self.firstName = firstName
    self.lastName = lastName
    self.scores = scores
  }
  
  func getGrade(_ averageScore: Double) -> String {
    switch averageScore {
    case 90...100:
      return "A"
    case 80..<90:
      return "B"
    case 70..<80:
      return "C"
    case 60..<70:
      return "D"
    default:
      return "F"
    }
  }
}

class EnglishStudent: Student {
  let termPaper: [Int]
  let midterm: [Int]
  let finalExam: [Int]
  
  init(firstName: String, lastName: String, termPaper: [Int], midterm: [Int], finalExam: [Int]) {
    self.termPaper = termPaper
    self.midterm = midterm
    self.finalExam = finalExam
    super.init(firstName: firstName, lastName: lastName, scores: termPaper + midterm + finalExam)
  }
  
  var averageScore: Double {
    let totalTermPaperScore = termPaper.reduce(0, +)
    let totalMidtermScore = midterm.reduce(0, +)
    let totalFinalExamScore = finalExam.reduce(0, +)
    
    let termPaperWeight = 0.25
    let midtermWeight = 0.35
    let finalExamWeight = 0.4
    
    let totalScore =
    Double(totalTermPaperScore) * termPaperWeight +
    Double(totalMidtermScore) * midtermWeight +
    Double(totalFinalExamScore) * finalExamWeight
    
    return round(100 * totalScore) / 100
  }
}

class HistoryStudent: Student {
  let attendance: [Int]
  let project: [Int]
  let midterm: [Int]
  let finalExam: [Int]
  
  init(firstName: String, lastName: String, attendance: [Int], project: [Int], midterm: [Int], finalExam: [Int]) {
    self.attendance = attendance
    self.project = project
    self.midterm = midterm
    self.finalExam = finalExam
    super.init(firstName: firstName, lastName: lastName, scores: attendance + project + midterm + finalExam)
  }
  
  var averageScore: Double {
    let totalAttendanceScore = attendance.reduce(0, +)
    let totalProjectScore    = project.reduce(0, +)
    let totalMidtermScore    = midterm.reduce(0, +)
    let totalFinalExamScore  = finalExam.reduce(0, +)
    
    let attendanceWeight = 0.1
    let projectWeight = 0.3
    let midtermWeight = 0.3
    let finalExamWeight = 0.3
    
    let totalScore =
    Double(totalAttendanceScore) * attendanceWeight +
    Double(totalProjectScore)    * projectWeight +
    Double(totalMidtermScore)    * midtermWeight +
    Double(totalFinalExamScore)  * finalExamWeight
    
    return round(100 * totalScore) / 100
  }
  
}

class MathStudent: Student {
  let quiz: [Int]
  let test: [Int]
  let finalExam: [Int]
  
  init(firstName: String, lastName: String, quiz: [Int], test: [Int], finalExam: [Int]) {
    self.quiz = quiz
    self.test = test
    self.finalExam = finalExam
    super.init(firstName: firstName, lastName: lastName, scores: quiz + test + finalExam)
  }
  
  var averageScore: Double {
    let totalQuizScore = quiz.reduce(0, +)
    let totalTestScore    = test.reduce(0, +)
    let totalFinalExamScore  = finalExam.reduce(0, +)
    
    let quizWeight = 0.15
    let testWeight = 0.25
    let finalExamWeight = 0.35
    
    let totalScore =
    (Double(totalQuizScore) / Double(self.quiz.count)) * quizWeight +
    Double(totalTestScore) * testWeight +
    Double(totalFinalExamScore)  * finalExamWeight
    
    return round(100 * totalScore) / 100
  }
  
}
