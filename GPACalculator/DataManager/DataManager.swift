//
//  DataManager.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GPACalculator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func semester(semester: SemesterModel) -> Semester {
        let semesterX = Semester(context: persistentContainer.viewContext)
        semesterX.name = semester.name
        semesterX.key = Int16(semester.key)
        semesterX.credits = Int16(semester.credits ?? 0)
        semesterX.gpa = semester.gpa ?? 0.0
        semesterX.isMarked = semester.isMarked ?? false
        return semesterX
    }
    
    func subject(name: String, grade: String, credits: Int, scale: Double, semester: Semester) -> Subject {
        let subject = Subject(context: persistentContainer.viewContext)
        subject.name = name
        subject.grade = grade
        subject.credits = Int16(credits)
        subject.scale = scale
        semester.addToSubjects(subject)
        return subject
    }
    
    func semesters() -> [Semester] {
        let request: NSFetchRequest<Semester> = Semester.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "key", ascending: true)]
        var fetchedSemesters: [Semester] = []
        do {
            fetchedSemesters = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching singers \(error)")
        }
        return fetchedSemesters
    }
    
    func subjects(semester: Semester) -> [Subject] {
        let request: NSFetchRequest<Subject> = Subject.fetchRequest()
        request.predicate = NSPredicate(format: "semester = %@", semester)
        //request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedSubjects: [Subject] = []
        
        do {
            fetchedSubjects = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        return fetchedSubjects
    }
    
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteSubject(subject: Subject) {
        let context = persistentContainer.viewContext
        context.delete(subject)
        save()
    }
    
    func deleteSemester(semester: Semester) {
        let context = persistentContainer.viewContext
        context.delete(semester)
        save()
    }
    
}
