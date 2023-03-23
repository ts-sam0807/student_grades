//
//  main.swift
//  StudentGrades
//
//  Created by Ts SaM on 23/3/2023.
//

import Foundation

var englishStudents: [EnglishStudent] = []
var historyStudents: [HistoryStudent] = []
var mathStudents: [MathStudent] = []

var grades:[String] = [];
var gradeA = 0;
var gradeB = 0;
var gradeC = 0;
var gradeD = 0;
var gradeF = 0;

// How to read a file?
let filename = "sample.in"
if let contents = try? String(contentsOfFile: "/Users/tssam/Documents/\(filename)") {
  //  print(contents)
  //  var readLine = 0;
  let lines = contents.components(separatedBy: .newlines)
  let totalLines = Int(lines[0])! * 2
  for i in stride(from: 1, through: totalLines, by: 2) {
    let line1Array = lines[i].components(separatedBy: ", ");
    let line2Array = lines[i + 1].components(separatedBy: " ")
    
    let firstName = line1Array[1]
    let lastName = line1Array[0]
    let course = line2Array[0]
    let scores = line2Array[1...].compactMap { Int($0) }
    
    switch course {
    case "English":
      let student = EnglishStudent(firstName: firstName, lastName: lastName, termPaper: [scores[0]], midterm: [scores[1]], finalExam: [scores[2]])
      englishStudents.append(student)
      
    case "History":
      let student = HistoryStudent(firstName: firstName, lastName: lastName, attendance: [scores[0]], project: [scores[1]], midterm: [scores[2]], finalExam: [scores[3]])
      historyStudents.append(student)
      
    case "Math":
      var quizzes: [Int] = []
      var tests: [Int] = []
      quizzes.append(scores[0])
      quizzes.append(scores[1])
      quizzes.append(scores[2])
      quizzes.append(scores[3])
      quizzes.append(scores[4])
      tests.append(scores[5])
      tests.append(scores[6])
      let student = MathStudent(firstName: firstName, lastName: lastName, quiz: quizzes, test: tests, finalExam: [scores[7]])
      mathStudents.append(student)
    default:
      print("Invalid input format: Unknown course '\(course)'")
      continue
    }
  }
}


//// How to write into a file ?
let outputFilename = "sample.out"
var outputString = "Student Grade Summary\n---------------------\n";

outputString += "\nENGLISH CLASS\n\n";
outputString += printHeader()

// Print English Students
for englishStudent in englishStudents {
  let name      = englishStudent.firstName + " " + englishStudent.lastName
  let fullname  = name.padding(toLength: 25, withPad: " ", startingAt: 0)
  let finalExam = String(englishStudent.finalExam[0]).padding(toLength: 8, withPad: " ", startingAt: 0)
  let avgScore  = String(englishStudent.averageScore).padding(toLength: 8, withPad: " ", startingAt: 0)
  let grade     = String(englishStudent.getGrade(englishStudent.averageScore)).padding(toLength: 8, withPad: " ", startingAt: 0)
  grades.append(englishStudent.getGrade(englishStudent.averageScore))
  outputString += "\(fullname)\(finalExam)\(avgScore)\(grade)" + "\n"
}

// Print History Students
outputString += "\nHISTORY CLASS\n\n";
outputString += printHeader()
for historyStudent in historyStudents {
  let name      = historyStudent.firstName + " " + historyStudent.lastName
  let fullname  = name.padding(toLength: 25, withPad: " ", startingAt: 0)
  let finalExam = String(historyStudent.finalExam[0]).padding(toLength: 8, withPad: " ", startingAt: 0)
  let avgScore  = String(historyStudent.averageScore).padding(toLength: 8, withPad: " ", startingAt: 0)
  let grade     = String(historyStudent.getGrade(historyStudent.averageScore)).padding(toLength: 8, withPad: " ", startingAt: 0)
  grades.append(historyStudent.getGrade(historyStudent.averageScore))
  outputString += "\(fullname)\(finalExam)\(avgScore)\(grade)" + "\n"
}

// Print Math Students
outputString += "\nMATH CLASS\n\n";
outputString += printHeader()
for mathStudent in mathStudents {
  let name      = mathStudent.firstName + " " + mathStudent.lastName
  let fullname  = name.padding(toLength: 25, withPad: " ", startingAt: 0)
  let finalExam = String(mathStudent.finalExam[0]).padding(toLength: 8, withPad: " ", startingAt: 0)
  let avgScore  = String(mathStudent.averageScore).padding(toLength: 8, withPad: " ", startingAt: 0)
  let grade     = String(mathStudent.getGrade(mathStudent.averageScore)).padding(toLength: 8, withPad: " ", startingAt: 0)
  grades.append(mathStudent.getGrade(mathStudent.averageScore))
  outputString += "\(fullname)\(finalExam)\(avgScore)\(grade)" + "\n"
}

outputString += "\n\nOVERALL GRADE DISTRIBUTION\n\n";

// Print Grades
gradeA = grades.filter({$0 == "A"}).count
gradeB = grades.filter({$0 == "B"}).count
gradeC = grades.filter({$0 == "C"}).count
gradeD = grades.filter({$0 == "D"}).count
gradeF = grades.filter({$0 == "F"}).count

outputString += "A: \t\(gradeA)\n";
outputString += "B: \t\(gradeB)\n";
outputString += "C: \t\(gradeC)\n";
outputString += "D: \t\(gradeD)\n";
outputString += "F: \t\(gradeF)\n";

if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
  let fileURL = dir.appending(path: outputFilename)
  do {
    try outputString.write(to: fileURL, atomically: false, encoding: .utf8)
    print("Sucessfully wrote into \(fileURL.absoluteString)")
  } catch {
    print(error.localizedDescription)
  }
}

func printHeader() -> String {
  var outputString = ""
  outputString += "Student".padding(toLength: 25, withPad: " ", startingAt: 0) + "Final".padding(toLength: 8, withPad: " ", startingAt: 0) + "Final".padding(toLength: 8, withPad: " ", startingAt: 0) + "Letter".padding(toLength: 8, withPad: " ", startingAt: 0) + "\n"
  outputString += "Name".padding(toLength: 25, withPad: " ", startingAt: 0) + "Exam".padding(toLength: 8, withPad: " ", startingAt: 0) + "Avg".padding(toLength: 8, withPad: " ", startingAt: 0) + "Grade".padding(toLength: 8, withPad: " ", startingAt: 0) + "\n"
  outputString += String(repeating: "-", count: 49) + "\n"

  return outputString
}

