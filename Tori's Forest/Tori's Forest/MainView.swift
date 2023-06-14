//
//  MainView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI
import CoreData

enum DataType {
    case plant
    case chapter
    case dialogue
//    case post
    case mission
}

struct MainView: View {
    @AppStorage("chapterIndex") var chapterIndex: Int = 0
    @AppStorage("plantIndex") var plantIndex: Int = 0
    @AppStorage("dialogIndex") var dialogIndex: Int = 0
    @AppStorage("missionIndex") var missionIndex: Int = 0
    @AppStorage("postIndex") var postIndex: Int = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var model = ViewModelPhone()
    
    @FetchRequest(sortDescriptors: [])
    private var plants: FetchedResults<Plant>

    @State var selectedTab: Int = 0
    @State var viewName: String = "Main"
    
    var body: some View {
//        NavigationStack {
            //TODO: 페이지 컨트롤러 간격 조정 + 선택된 탭 인식하여 selected 이미지로 변환
            ZStack {
                TabView(selection: $selectedTab) {
                    NavigationStack {
                        PlantPotView(viewName: $viewName, chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, postIndex: $postIndex)
                            .tabItem {
                                Image("STR_Img_asset_button_pot_selected")
                                    .resizable()
                                    .frame(width: 27, height: 24)
                            }
                    }
                        .environment(\.managedObjectContext, viewContext)
                        .tag(0)
                    
                    PlantPotView(viewName: $viewName, chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, postIndex: $postIndex)
                        .tabItem {
                            Image("STR_Img_asset_button_pot")
                                .resizable()
                                .frame(width: 27, height: 24)
                        }
                        .environment(\.managedObjectContext, viewContext)
                        .disabled(true)
                        .tag(1)
                    
                    PlantPotView(viewName: $viewName, chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, postIndex: $postIndex)
                        .tabItem {
                            Image("STR_Img_asset_button_pot")
                                .resizable()
                                .frame(width: 27, height: 24)
                        }
                        .environment(\.managedObjectContext, viewContext)
                        .disabled(true)
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                VStack {
                    Spacer()
                    
                    CustomTabBar(selectedTab: $selectedTab)
                        .padding(.bottom)
                }
//            }
            .ignoresSafeArea()
        }
        .onAppear {
            chapterIndex = 0
            plantIndex = 0
            dialogIndex = 0
            missionIndex = 0
            
            deleteAllDataFromAllEntities()
            loadData()
            self.model.sendMessageToWatch(message: [
                "민들레씨": "창문 30분 열어 환기하기",
                "???": "아침에 이불 정리하기",
                "????": "하루에 한 번 샤워하기"
            ])
        }
    }
    
    func loadData() {
//        if plants.count == 0 {
            // 데이터 추가
            print("CoreData : initialize data")
//            deleteAllDataFromAllEntities()
            getData()
            print("CoreData: \(plants.count) plants added")
//        }
//        else{
//            print("CoreData : Already \(plants.count) plants exists")
//        }
    }
    
    func deleteAllData(_ entityName: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
            print("deleted")
        } catch {
            print ("There was an error")
        }
    }

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
//        getCSVData("Post", .post)
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
            var columns = row.components(separatedBy: ",")
            
            print(row)
            print(columns)
            
            switch dataType {
            case .plant:
                // 데이터 컬럼 개수 1개 이상일 때 (
                if columns.count > 0 && columns != [""] {
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
                
//            case .post:
//                if columns.count > 0 && columns != [""] {
//                    let id = Int64(columns[0])!
//                    let missionID = Int64(columns[1])!
//                    let image = columns[2]
//                    let description = columns[3]
//                    let createdAt = formatDate(columns[4])
//
//                    addPost(id, missionID, image, description, createdAt)
//            }
                
            case .mission:
                if columns.count > 0 && columns != [""] {
                    let id = Int64(columns[0])!
                    let plantID = Int64(columns[1])!
                    let chapterID = Int64(columns[2])!
                    let header = columns[3]
                    let description = columns[4]

                    addMission(id, plantID, chapterID, header, description)
                }
//            default:
//                print("Nothing from CSV file")
            }
        }
    }
    
    
    func addPlant(_ id: Int64, _ name: String, _ level: Int64, _ objectName: String, _ description: String) {
        let plant = Plant(context: viewContext)
        
        plant.plantID = id
        plant.plantName = name
        plant.level = level
        plant.objectName = objectName
        plant.plantDescription = description
        
        saveContext()
    }
    
    func addChapter(_ id: Int64, _ header: String, _ subHeader: String, _ description: String) {
        let chapter = Chapter(context: viewContext)
        
        chapter.chapterID = id
        chapter.chapterHeader = header
        chapter.chapterSubHeader = subHeader
        chapter.chapterDescription = description
        
        saveContext()
    }

    func addDialogue(_ id: Int64, _ missionID: Int64, _ isPrev: Bool, _ line: String) {
        let dialog = Dialog(context: viewContext)
        
        dialog.dialogID = id
        dialog.missionID = missionID
        dialog.isPrev = isPrev
        dialog.dialogLine = line
        
        saveContext()
    }

//    func addPost(_ id: Int64, _ missionID: Int64, _ image: String, _ description: String, _ createdAt: Date) {
//        let post = Post(context: viewContext)
//
//        post.postID = id
//        post.missionID = missionID
//        post.imageName = image
//        post.postDescription = description
//        post.createdAt = createdAt
//
//        saveContext()
//    }

    func addMission(_ id: Int64, _ plantID: Int64, _ chapterID: Int64, _ header: String, _ description: String) {
        let mission = Mission(context: viewContext)
    
        mission.missionID = id
        mission.plantID = plantID
        mission.chapterID = chapterID
        mission.missionHeader = header
        mission.missionDescription = description
    
        saveContext()
    }
    
    func saveContext() {
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

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Button(action: {
                selectedTab = 0
            }) {
                Image(selectedTab == 0 ? "STR_Img_asset_button_pot_selected" : "STR_Img_asset_button_pot")
                    .resizable()
                    .frame(width: 27, height: 24)
            }
            .padding(.trailing, 10)
            
            Button(action: {
                selectedTab = 1
            }) {
                Image(selectedTab == 1 ? "STR_Img_asset_button_pot_selected" : "STR_Img_asset_button_pot")
                    .resizable()
                    .frame(width: 27, height: 24)
            }
            .padding(.trailing, 10)
            
            Button(action: {
                selectedTab = 2
            }) {
                Image(selectedTab == 2 ? "STR_Img_asset_button_pot_selected" : "STR_Img_asset_button_pot")
                    .resizable()
                    .frame(width: 27, height: 24)
            }
            .padding(.trailing, 10)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
