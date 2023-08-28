//
//  CoreDataManager.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/08/22.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    static let coreDM = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores {(description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func readPlants() -> [Plant] {
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func loadData() {
        let plants = self.readPlants()
        
        if plants.count == 0 {
            // 데이터 추가
            print("CoreData : initialize data")
            deleteAllDataFromAllEntities()
            getData()
            print("CoreData: \(plants.count) plants added")
        }
        else{
            print("CoreData : Already \(plants.count) plants exists")
        }
    }

    //TODO: 주석
    func deleteAllData(_ entityName: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        let viewContext = persistentContainer.viewContext

        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
            print("deleted")
        } catch {
            print("There was an error")
        }
    }
    //TODO: 주석
    func deleteAllDataFromAllEntities() {
        deleteAllData("Plant")
        deleteAllData("Dialog")
        deleteAllData("Chapter")
        deleteAllData("Post")
        deleteAllData("Mission")
    }

    func getData() {
        getCSVData("Plant", .plant)
        getCSVData("Chapter", .chapter)
        getCSVData("Dialog", .dialogue)
        getCSVData("Mission", .mission)
    }

    func getCSVData(_ fileName: String, _ dataType: DataType) {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("Error: Could not find CSV file")

            return
        }
        var data = ""

        do {
            data = try String(contentsOfFile: filepath)
        } catch {
            print(error)

            return
        }
        let rows = data.components(separatedBy: "\r\n")

        for row in rows {
            let columns = row.components(separatedBy: ",")

            print(row)
            print(columns)

            switch dataType {
            case .plant:
                if (columns.count > 0) && (columns != [""]) {
                    let id = Int64(columns[0])!
                    let name = columns[1]
                    let level = Int64(columns[2])!
                    let objectName = columns[3]
                    let description = columns[4]

                    addPlant(id, name, level, objectName, description)
                }
            case .chapter:
                if columns.count > 0 && columns != [""] {
                    let id = Int64(columns[0])!
                    let header = columns[1]
                    let subHeader = columns[2]
                    let description = columns[3]

                    addChapter(id, header, subHeader, description)
                }
            case .dialogue:
                if columns.count > 0 && columns != [""] {
                    let id = Int64(columns[0])!
                    let missionID = Int64(columns[1])!
                    let isPrev = Bool(columns[2])!
                    let line = columns[3]

                    addDialogue(id, missionID, isPrev, line)
                }
            case .mission:
                if columns.count > 0 && columns != [""] {
                    let id = Int64(columns[0])!
                    let plantID = Int64(columns[1])!
                    let chapterID = Int64(columns[2])!
                    let header = columns[3]
                    let description = columns[4]

                    addMission(id, plantID, chapterID, header, description)

                    print("Mission: \(columns.count)")
                }
            }
        }
    }

    func addPlant(_ id: Int64, _ name: String, _ level: Int64, _ objectName: String, _ description: String) {
        let viewContext = persistentContainer.viewContext
        let plant = Plant(context: viewContext)

        plant.plantID = id
        plant.plantName = name
        plant.level = level
        plant.objectName = objectName
        plant.plantDescription = description

        saveContext()
    }

    func addChapter(_ id: Int64, _ header: String, _ subHeader: String, _ description: String) {
        let viewContext = persistentContainer.viewContext
        let chapter = Chapter(context: viewContext)

        chapter.chapterID = id
        chapter.chapterHeader = header
        chapter.chapterSubHeader = subHeader
        chapter.chapterDescription = description

        saveContext()
    }

    func addDialogue(_ id: Int64, _ missionID: Int64, _ isPrev: Bool, _ line: String) {
        let viewContext = persistentContainer.viewContext
        let dialog = Dialog(context: viewContext)

        dialog.dialogID = id
        dialog.missionID = missionID
        dialog.isPrev = isPrev
        dialog.dialogLine = line

        saveContext()
    }
    
    func addMission(_ id: Int64, _ plantID: Int64, _ chapterID: Int64, _ header: String, _ description: String) {
        let viewContext = persistentContainer.viewContext
        let mission = Mission(context: viewContext)

        mission.missionID = id
        mission.plantID = plantID
        mission.chapterID = chapterID
        mission.missionHeader = header
        mission.missionDescription = description

        saveContext()
    }

    func saveContext() {
        let viewContext = persistentContainer.viewContext
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }

    func formatDate(_ date: String) -> Date {
        let dateFormat = "yyyMMdd"
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = dateFormat

        if let convertedDate = dateFormatter.date(from: date) {
            return convertedDate
        } else {
            return Date()
        }
    }
}

