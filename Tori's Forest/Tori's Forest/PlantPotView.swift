//
//  PlantPotView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct PlantPotView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.scenePhase) private var scenePhase

    @StateObject private var keyboardHandler = KeyboardHandler()
    
    @FetchRequest(sortDescriptors: [])
    var plants: FetchedResults<Plant>
    
    @FetchRequest(sortDescriptors: [])
    var dialogs: FetchedResults<Dialog>
    
    @FetchRequest(sortDescriptors: [])
    var missions: FetchedResults<Mission>
    
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var dialogIndex: Int
    @Binding var missionIndex: Int
    @Binding var postIndex: Int
    @Binding var isAllChapterCompleted: Bool

    @State var isEmpty: Bool = true
    @State var isShowPlantSelectView: Bool = false
    @State var isShowDiaryView: Bool = false
    @State var isMissionCompleted: Bool = false
    @State var isChapterCompleted: Bool = false
    @State var isTapped: Bool = false
    @State var maximum: Int = 3
    
    let backgrounds: Array<String> = ["STR_Img_bg_1_spring", "STR_Img_bg_2_summer", "STR_Img_bg_3_autumn", "STR_Img_bg_4_winter"]
    
    var body: some View {
        let emptyPot = "STR_3D_emptypot.scn"
        let potName = plants[Int(missions[missionIndex].plantID)-1].objectName
        
        if chapterIndex < 4 {
            ZStack {
                Image(backgrounds[chapterIndex])
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        NavigationLink(
                            destination:
                                GardenView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, missionIndex: $missionIndex, postIndex: $postIndex, isChapterCompleted: $isChapterCompleted)
                                .environment(\.managedObjectContext, viewContext)
                                .navigationBarBackButtonHidden(true)
                        ) {
                            Image("STR_Img_asset_button_main")
                                .resizable()
                                .frame(width: 45, height: 45)
                        }
                        
                        Spacer()
                        
                        if !isEmpty {
                            CustomProgressBar(missionIndex: $missionIndex, maximum: $maximum)
                                .environment(\.managedObjectContext, viewContext)
                        }
                    }
                    .padding()
                    
                    if isEmpty {
                        Spacer()
                        ZStack {
                            Image(systemName: "plus.square")
                                .resizable()
                                .foregroundColor(Color("STR_White"))
                                .fontWeight(.bold)
                                .frame(width: 22, height: 22)
                                .offset(y: -100)
                            
                            PlantSceneView(sceneViewName: emptyPot)
                                .scaledToFit()
                                .frame(width: 180, height: 300)
                                .offset(y: 30)
                        }
                        .onTapGesture {
                            self.isShowPlantSelectView.toggle()
                        }
                        
                        Spacer()
                    } else {
                        MessageBox(chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, isEmpty: $isEmpty, isMissionCompleted: $isMissionCompleted, isChapterCompleted: $isChapterCompleted, isAllChapterCompleted: $isAllChapterCompleted)
                            .environment(\.managedObjectContext, viewContext)
                            .opacity(isMissionCompleted != dialogs[dialogIndex].isPrev ? 1: 0)
                        
                        Spacer()
                        
                        ZStack {
                            Image("STR_Img_asset_button_info")
                                .resizable()
                                .opacity(isMissionCompleted == dialogs[dialogIndex].isPrev ? 1 : 0)
                                .opacity(chapterIndex == 3 ? 1 : 0)
                                .frame(width: 34, height: 30)
                                .offset(y: -180)
                            
                            PlantSceneView(sceneViewName: potName!)
                                .environment(\.managedObjectContext, viewContext)
                                .frame(width: 250, height: 300)
                            
                            if isMissionCompleted && chapterIndex == 0{
                                LottieView(jsonName: "STR_Lottie_dandelion")
                                    .frame(width: 150, height: 200)
                                    .offset(x: 40, y: -130)
                            }
                        }
                        
                        Spacer()
                        
                        MissionBox(isShowDiaryView: $isShowDiaryView, isMissionCompleted: $isMissionCompleted, missionIndex: $missionIndex, isTapped: $isTapped)
                            .environment(\.managedObjectContext, viewContext)
                            .disabled(dialogs[dialogIndex].isPrev)
                            .opacity(isMissionCompleted==dialogs[dialogIndex].isPrev ? 1 : 0)
                            .padding(.top, 80)
                        
                        Spacer()
                    }
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .background && chapterIndex == 1 {
                        NotificationManager.shared.scheduleNotification()
                    }
                }
                
                if isShowPlantSelectView {
                    PlantSelectView(isEmpty: $isEmpty, isShowPlantSelectView: $isShowPlantSelectView, chapterIndex: $chapterIndex, plantIndex: $plantIndex, missionIndex: $missionIndex)
                        .environment(\.managedObjectContext, viewContext)
                        .offset(y: 135)
                        .animation(.spring())
                        .background(Color.gray.opacity(0.4))
                }
                
                if isShowDiaryView {
                    DiaryView(isShowDiaryView: $isShowDiaryView, isMissionCompleted: $isMissionCompleted,
                              isTapped: $isTapped, postIndex: $postIndex, chapterIndex: chapterIndex, missionIndex: missionIndex)
                    .environment(\.managedObjectContext, viewContext)
                    .frame(width: 356, height: 513)
                    .background(.white)
                    .cornerRadius(10)
                    .offset(y: keyboardHandler.keyboardHeight == 0 ? -20 : (keyboardHandler.keyboardHeight - 320))
                }
                
                if isChapterCompleted {
                    ChapterOverView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, missionIndex: $missionIndex, postIndex: $postIndex, isChapterCompleted: $isChapterCompleted)
                        .environment(\.managedObjectContext, viewContext)
                        .frame(width: 306, height: 426)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
            }
        }
    }
    private func popUpView() -> some View {
        ChapterOverView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, missionIndex: $missionIndex, postIndex: $postIndex, isChapterCompleted: $isChapterCompleted)
            .environment(\.managedObjectContext, viewContext)
            .frame(width: 306, height: 426)
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 2)
    }
}
