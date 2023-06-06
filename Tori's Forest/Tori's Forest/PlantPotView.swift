//
//  PlantPotView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct PlantPotView: View {
    @State var viewName: String = "Main"
    @State var isEmpty: Bool = true
    @State var emptyPot: String = "test"
    @State var plantIndex: Int = 0
    @State var plantStage: Int = 0
    @State var showPlantSelectView: Bool = false
    @State var showDiaryView: Bool = false
    @State var isMissionCompleted: Bool = false
    @State var isChapterCompleted: Bool = false

    @Binding var chapterID: Int
    @Binding var plants: Array<Plant>
    @Binding var days: Int
    
    var body: some View {
        VStack {
            HStack {
                ViewChangeButton(viewName: $viewName)
                Spacer()
                CustomProgressBar(plantStage: $plantStage, days: $days)
            }
            .padding()
//            MessageBox(messages: $messages)
            if isEmpty {
                Image(emptyPot)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        self.showPlantSelectView.toggle()
                    }
                } else {
                    if isMissionCompleted {
                        MessageBox(plantStage: $plantStage, chapterID: $chapterID, messages: $plants[plantIndex].messages[plantStage], isMissionCompleted: $isMissionCompleted, isChapterCompleted: $isChapterCompleted, isEmpty: $isEmpty, days: $days)
                    }
                    Image(plants[plantIndex].images[plantStage])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    MissionBox(mission: $plants[plantIndex].missions[plantStage], showDiaryView: $showDiaryView, isMissionCompleted: $isMissionCompleted)
            }
        }
        .sheet(isPresented: self.$showPlantSelectView) {
            PlantSelectView(isEmpty: $isEmpty, showPlantSelectView: $showPlantSelectView, plants: $plants, plantIndex: $plantIndex)
            //                        .presentationBackground(.clear)
        }
        .sheet(isPresented: self.$showDiaryView) {
            DiaryView(showDiaryView: $showDiaryView)
        }
        .sheet(isPresented: $isChapterCompleted) {
            ChapterOverView(chapterID: $chapterID, isChapterCompleted: $isChapterCompleted)
        }
    }
}

struct PlantPotView_Previews: PreviewProvider {
    static var previews: some View {
       MainView()
    }
}
