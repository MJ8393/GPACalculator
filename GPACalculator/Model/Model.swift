//
//  Model.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

struct SemesterModel: Equatable {
    let key: Int
    let name: String
    let gpa: Double?
    let credits: Int?
    var isMarked: Bool?
}

var selectedSemesters = [SemesterModel]()

var allsemesters = [
    SemesterModel(key: 1, name: "Semester 1", gpa: nil, credits: nil, isMarked: false),
    SemesterModel(key: 2, name: "Semester 2", gpa: nil, credits: nil, isMarked: false),
    SemesterModel(key: 3, name: "Semester 3", gpa: nil, credits: nil, isMarked: false),
    SemesterModel(key: 4, name: "Semester 4", gpa: nil, credits: nil, isMarked: false),
    SemesterModel(key: 5, name: "Semester 5", gpa: nil, credits: nil, isMarked: false),
    SemesterModel(key: 6, name: "Semester 6", gpa: nil, credits: nil, isMarked: false),
    SemesterModel(key: 7, name: "Semester 7", gpa: nil, credits: nil, isMarked: false),
    SemesterModel(key: 8, name: "Semester 8", gpa: nil, credits: nil, isMarked: false),
]

struct Grade {
    let name: String
    let scale: Double
}

let grades = grades1

let grades1 = [
    Grade(name: "A +", scale: 4.5),
    Grade(name: "A0", scale: 4.0),
    Grade(name: "B +", scale: 3.5),
    Grade(name: "B0", scale: 3.0),
    Grade(name: "C +", scale: 2.5),
    Grade(name: "C0", scale: 2.0),
    Grade(name: "D +", scale: 1.5),
    Grade(name: "D0", scale: 1.0),
    Grade(name: "F", scale: 0.0),
    Grade(name: "GPA", scale: 0.0),
]

let grades2 = [
    Grade(name: "5", scale: 5.0),
    Grade(name: "4", scale: 4.0),
    Grade(name: "3", scale: 3.0),
    Grade(name: "F", scale: 0.0),
    Grade(name: "GPA", scale: 0.0),
]

let grades3 = [
    Grade(name: "A +", scale: 4.0),
    Grade(name: "A", scale: 4.0),
    Grade(name: "A -", scale: 3.7),
    Grade(name: "B +", scale: 3.3),
    Grade(name: "B", scale: 3.0),
    Grade(name: "B -", scale: 2.7),
    Grade(name: "C +", scale: 2.3),
    Grade(name: "C", scale: 2.0),
    Grade(name: "C -", scale: 1.7),
    Grade(name: "D +", scale: 1.3),
    Grade(name: "D", scale: 1.0),
    Grade(name: "F", scale: 0.0),
    Grade(name: "GPA", scale: 0.0),
]

let gradeDict = gradeDict1

let gradeDict1: [String: Int] = ["A +": 0, "A0": 1, "B +": 2, "B0": 3, "C +": 4, "C0": 5, "D +": 6, "D0": 7, "F": 8, "GPA": 9]
let gradeDict2: [String: Int] = ["5": 0, "4": 1, "3": 2, "F": 3, "GPA": 4]
let gradeDict3: [String: Int] = ["A +": 0, "A": 1, "A -": 2, "B +": 3, "B": 4, "B -": 5, "C +": 6, "C": 7, "C -": 8, "D +": 9, "D": 10, "F": 11, "GPA": 12]



struct SubjectModel {
    let name: String
    let grade: String
    let credits: Int
    let scale: Double
}

let universities = ["Inha university in Tashkent", "WIUT", "Tashkent Finance Institute", "TUIT"]
let subjects: [Int: [[SubjectModel]]] = [0: [
    [
    SubjectModel(name: "Academic English Reading", grade: "GPA", credits: 2, scale: 0.0),
    SubjectModel(name: "Academic English 1", grade: "GPA", credits: 2, scale: 0.0),
    SubjectModel(name: "Calculus 1", grade: "GPA", credits: 3, scale: 0.0),
    SubjectModel(name: "Physics 1", grade: "GPA", credits: 3, scale: 0.0),
    SubjectModel(name: "Physics Experiment 1", grade: "GPA", credits: 1, scale: 0.0),
    SubjectModel(name: "Object Oriented Programming 1", grade: "GPA", credits: 3, scale: 0.0),
    SubjectModel(name: " Introduction to IT", grade: "GPA", credits: 3, scale: 0.0),
    ],
    
    [
    SubjectModel(name: "Academic English Reading", grade: "GPA", credits: 2, scale: 0.0),
    SubjectModel(name: "Academic English 1", grade: "GPA", credits: 2, scale: 0.0),
    SubjectModel(name: "Calculus 1", grade: "GPA", credits: 3, scale: 0.0),
    SubjectModel(name: "Physics 1", grade: "GPA", credits: 3, scale: 0.0),
    SubjectModel(name: "Physics Experiment 1", grade: "GPA", credits: 1, scale: 0.0),
    SubjectModel(name: "Object Oriented Programming 1", grade: "GPA", credits: 3, scale: 0.0),
    SubjectModel(name: " Introduction to IT", grade: "GPA", credits: 3, scale: 0.0),
    ],
    
    
],
   
]


var dataGrades: [[String]] = [
    [
        "Grade", "Percent (Absolute)", "Scale",
        "5", "90 - 100", "5.0",
        "4", "70 - 89.9", "4.0",
        "3", "60 - 69.9", "3.0",
        "F", "Below 59.9", "0.0",
    ],
    [
        "Grade", "Percent (Relative)", "Scale",
        "A+", "10", "4.5",
        "A0", "10", "4.0",
        "B+", "15", "3.5",
        "B0", "15", "3.0",
        "C+", "15", "2.5",
        "C0", "15", "2.0",
        "D+", "10", "1.5",
        "D0", "<=10", "1.0",
        "F", "<=10", "0.0",
    ],
    [
        "Grade", "Percent (Absolute)", "Scale",
        "A+", "97 - 100", "4.0",
        "A", "93 - 96", "4.0",
        "A-", "90 - 92", "3.7",
        "B+", "87 - 89", "3.3",
        "B", "83 - 86", "3.0",
        "B-", "80 - 82", "2.7",
        "C+", "77 - 79", "2.3",
        "C", "73 - 76", "2.0",
        "C-", "70 - 72", "1.7",
        "D+", "67 - 69", "1.3",
        "D", "65 - 66", "1.0",
        "F", "Below 65", "0.0",
    ]
]

struct Setting {
    let name: String
    let icon: UIImage
    let desc: String?
    let hasSwitch: Bool
}

let settings = [
    Setting(name: "Grading system", icon: UIImage(systemName: "square.and.pencil")!, desc: "5.0(Uzbekistan)", hasSwitch: false),
    Setting(name: "Language", icon: UIImage(systemName: "globe.europe.africa")!, desc: "English", hasSwitch: false),
    Setting(name: "Dark mode", icon: UIImage(systemName: "cloud.moon")!, desc: nil, hasSwitch: true),
    Setting(name: "Contact developer", icon: UIImage(systemName: "phone.arrow.up.right")!, desc: nil, hasSwitch: false),
    Setting(name: "Share app", icon: UIImage(systemName: "arrowshape.turn.up.right")!, desc: nil, hasSwitch: false)
]
