//
//  GardenView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct GardenView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var gardenObject = GardenObject()
    
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var missionIndex: Int
    @Binding var postIndex: Int
    @Binding var isChapterCompleted: Bool
    
    @State var selectedViewName: String = ""
    @State var isShowPlantHistoryView: Bool = false
    @State var maximum: Int = 12
    
    
    let backgrounds: Array<String> = ["STR_Img_bg_1_spring", "STR_Img_bg_2_summer", "STR_Img_bg_3_autumn", "STR_Img_bg_4_winter"]
    
    var body: some View {
        let progress = CGFloat.zero
        
        ZStack {
            if chapterIndex < 4 {
                Image(backgrounds[chapterIndex])
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Image("STR_Img_bg_1_spring")
                    .resizable()
                    .ignoresSafeArea()
            }
            VStack {
                if chapterIndex < 4 {
                    HStack {
                        Button(action: {
                            isChapterCompleted = false
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("STR_Img_asset_button_garden")
                                .resizable()
                                .frame(width: 45, height: 45)
                        }
                        
                        Spacer()
                        
                        CustomProgressBar(missionIndex: $missionIndex, maximum: $maximum)
                    }
                    .frame(maxWidth: 360)
                    .padding()
                }
                
                
                Spacer()
                
                //TODO: sheet 정보를 선택된 3d object 기준으로 변경
                GardenSceneView(chapterIndex: $chapterIndex,
                                isShowPlantHistoryView: $isShowPlantHistoryView,
                                selectedName: $selectedViewName
                )
                .frame(width: 500, height: 400)
                .environmentObject(gardenObject)
                .sheet(isPresented: self.$isShowPlantHistoryView) {
                    PlantHistoryView(selectedViewName: $selectedViewName)
                }
                
                Spacer()
                
                Button(action: { print("AR is on") }) {
                    NavigationLink(destination: ARContentView(chapterIndex: $chapterIndex)) {
                        Image("STR_Img_asset_button_AR")
                            .resizable()
                            .frame(width: 46.45, height: 46.43)
                    }
                }
            }
        }
    }
}
