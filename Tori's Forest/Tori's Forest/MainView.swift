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
    private var plants: FetchedResults<Mission>
    
    @State var selectedTab: Int = 0
    @State var isAllChapterCompleted: Bool = false
    
    var body: some View {
        if !isAllChapterCompleted {
            ZStack {
                TabView(selection: $selectedTab) {
                    PlantPotView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, postIndex: $postIndex, isAllChapterCompleted: $isAllChapterCompleted)
                        .environment(\.managedObjectContext, viewContext)
                        .tag(0)
                    
                    PlantPotView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, postIndex: $postIndex, isAllChapterCompleted: $isAllChapterCompleted)
                        .environment(\.managedObjectContext, viewContext)
                        .disabled(true)
                        .tag(1)
                    
                    PlantPotView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, postIndex: $postIndex, isAllChapterCompleted: $isAllChapterCompleted)

                        .environment(\.managedObjectContext, viewContext)
                        .disabled(true)
                        .tag(2)
                }
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                        .padding(.bottom)
                }
            }
            
        } else {
            EndingView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, missionIndex: $missionIndex, postIndex: $postIndex)
                .environment(\.managedObjectContext, viewContext)
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
}
