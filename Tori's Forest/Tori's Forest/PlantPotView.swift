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
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    @FetchRequest(sortDescriptors: [])
    var plants: FetchedResults<Plant>
    
    @FetchRequest(sortDescriptors: [])
    var dialogs: FetchedResults<Dialog>
    
    @FetchRequest(sortDescriptors: [])
    var missions: FetchedResults<Mission>
    
    @Binding var viewName: String
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var dialogIndex: Int
    @Binding var missionIndex: Int
    @Binding var postIndex: Int

    @State var isEmpty: Bool = true
    @State var isShowPlantSelectView: Bool = false
    @State var isShowDiaryView: Bool = false
    @State var isMissionCompleted: Bool = false
    @State var isTapped: Bool = false
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
                    NavigationLink(
                        destination:
                            GardenView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, postIndex: $postIndex)
                            .environment(\.managedObjectContext, viewContext)
                            .navigationBarBackButtonHidden(true)
                    ) {
                        Image("STR_Img_asset_button_main")
                            .resizable()
                            .frame(width: 45, height: 45)
                    }
                    
                    Spacer()
                    
                    if !isEmpty {
                        CustomProgressBar(progress: progress)
                    }
                }
                .padding()
                
                if isEmpty {
                    Spacer()
                    
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
                    MessageBox(chapterIndex: $chapterIndex, plantIndex: $plantIndex, dialogIndex: $dialogIndex, missionIndex: $missionIndex, isEmpty: $isEmpty, isMissionCompleted: $isMissionCompleted, isChapterCompleted: $isChapterCompleted)
                        .environment(\.managedObjectContext, viewContext)
                        .opacity(isMissionCompleted != dialogs[dialogIndex].isPrev ? 1: 0)
                    
                    Spacer()
                    
                    PlantSceneView(sceneViewName: potName!)
                        .environment(\.managedObjectContext, viewContext)
                        .frame(width: 250, height: 300)
                    
                    Spacer()
                    
                    MissionBox(isShowDiaryView: $isShowDiaryView, isMissionCompleted: $isMissionCompleted, missionIndex: $missionIndex, isTapped: $isTapped)
                        .environment(\.managedObjectContext, viewContext)
                        .disabled(dialogs[dialogIndex].isPrev)
                        .opacity(isMissionCompleted==dialogs[dialogIndex].isPrev ? 1 : 0)
                        .padding(.top, 80)
                    
                    Spacer()
                }
            }
            .popup(isPresented: self.$isShowPlantSelectView) {
                PlantSelectView(isEmpty: $isEmpty, isShowPlantSelectView: $isShowPlantSelectView, chapterIndex: $chapterIndex, plantIndex: $plantIndex, missionIndex: $missionIndex)
                    .environment(\.managedObjectContext, viewContext)
            } customize: {
                $0
                    .type(.default)
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(false)
                    .closeOnTap(false)
                    .backgroundColor(Color.gray.opacity(0.4))
            }
            
            .popup(isPresented: self.$isShowDiaryView) {
                DiaryView(isShowDiaryView: $isShowDiaryView, isMissionCompleted: $isMissionCompleted,
                          isTapped: $isTapped, postIndex: $postIndex, chapterIndex: chapterIndex, missionIndex: missionIndex)
                    .environment(\.managedObjectContext, viewContext)
                    .frame(width: 356, height: 513)
                    .background(.white)
                    .cornerRadius(10)
                    .offset(y: keyboardHandler.keyboardHeight == 0 ? -40 : (keyboardHandler.keyboardHeight * -1 + 100))
            } customize: {
                $0
                    .isOpaque(true)
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
