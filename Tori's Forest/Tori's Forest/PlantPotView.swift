//
//  PlantPotView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI
import PopupView

struct PlantPotView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var plants: FetchedResults<Plant>
    
    @FetchRequest(sortDescriptors: [])
    var dialogs: FetchedResults<Dialog>
    
    @FetchRequest(sortDescriptors: [])
    var missions: FetchedResults<Mission>
    
//    @AppStorage("chapterIndex") var chapterIndex: Int = 0
//    @AppStorage("plantIndex") var plantIndex: Int = 0
//    @AppStorage("dialogIndex") var dialogIndex: Int = 0
//    @AppStorage("missionIndex") var missionIndex: Int = 0
//    @AppStorage("postIndex") var postIndex: Int = 0
    
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var dialogIndex: Int
    @Binding var missionIndex: Int
    @Binding var postIndex: Int
    
    @State var viewName: String = "Main"
    @State var isEmpty: Bool = true
//    @State var emptyPot: String = "STR_3D_emptypot.scn"
//    @State var potImage: String = plants[plantIndex].objectName
    @State var isShowPlantSelectView: Bool = false
    @State var isShowDiaryView: Bool = false
    @State var isMissionCompleted: Bool = false
    @State var isChapterCompleted: Bool = false
    
    let backgrounds: Array<String> = ["STR_Img_bg_1_spring", "STR_Img_bg_2_summer", "STR_Img_bg_3_autumn", "STR_Img_bg_4_winter"]
    
    var body: some View {
        let progress = isEmpty ? CGFloat.zero : CGFloat(1)
        let emptyPot = "STR_3D_emptypot.scn"
        let potName = plants[Int(missions[missionIndex].plantID)-1].objectName
        
        ZStack {
            Image(backgrounds[chapterIndex])
                .resizable()
                .ignoresSafeArea()
            VStack {
                HStack {
                    ViewChangeButton(chapterIndex: $chapterIndex, plantIndex: $plantIndex, postIndex: $postIndex, viewName: $viewName)
                        .environment(\.managedObjectContext, viewContext)
                    
                    Spacer()
                    
                    if !isEmpty {
                        CustomProgressBar(progress: progress)
                    }
                }
                .padding()
                
                Spacer()
                
                if isEmpty {
                    ZStack {
                        Image(systemName: "plus.square")
                            .resizable()
                            .foregroundColor(Color("STR_Green"))
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
                    if isMissionCompleted != dialogs[dialogIndex].isPrev {
                        MessageBox(chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, isEmpty: $isEmpty, isMissionCompleted: $isMissionCompleted, isChapterCompleted: $isChapterCompleted)
                            .environment(\.managedObjectContext, viewContext)
                    }
                    
                    PlantSceneView(sceneViewName: potName!)
                        .environment(\.managedObjectContext, viewContext)
                    
                    if isMissionCompleted == dialogs[dialogIndex].isPrev {
                        MissionBox(isShowDiaryView: $isShowDiaryView, isMissionCompleted: $isMissionCompleted, missionIndex: $missionIndex)
                            .environment(\.managedObjectContext, viewContext)
                            .disabled(dialogs[dialogIndex].isPrev)
                    }
                }
            }
            .sheet(isPresented: self.$isShowPlantSelectView) {
                PlantSelectView(isEmpty: $isEmpty, showPlantSelectView: $isShowPlantSelectView, chapterIndex: chapterIndex, plantIndex: plantIndex, missionIndex: missionIndex)
                    .environment(\.managedObjectContext, viewContext)
            }
            .popup(isPresented: self.$isShowDiaryView) {
                DiaryView(isShowDiaryView: $isShowDiaryView, isMissionCompleted: $isMissionCompleted, postIndex: $postIndex, chapterIndex: chapterIndex, missionIndex: missionIndex)
                    .environment(\.managedObjectContext, viewContext)
                    .frame(width: 356, height: 513)
                    .background(.white)
                    .cornerRadius(10)
                    .offset(y: -20)
            } customize: {
                $0
                    .isOpaque(true)
//                    .closeOnTapOutside(true)
                //TDOD: 현재 작동하지 않음 -> 개선 필요
//                    .dragToDismiss(true)
                    .closeOnTap(false)
            }
            .popup(isPresented: $isChapterCompleted) {
                ChapterOverView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, postIndex: $postIndex, isChapterCompleted: $isChapterCompleted)
                    .environment(\.managedObjectContext, viewContext)
                    .frame(width: 306, height: 426)
                    .background(.white)
                    .cornerRadius(10)
            } customize: {
                $0
                    .isOpaque(true)
            }
        }
    }
}

struct PlantPotView_Previews: PreviewProvider {
    static var previews: some View {
       MainView()
    }
}
