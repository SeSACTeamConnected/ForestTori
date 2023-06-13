//
//  GardenView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct GardenView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var gardenObject = GardenObject()
    
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var postIndex: Int
    
    @State var viewName: String = "Garden"
    @State var selectedViewName: String = ""
    @State var isShowPlantHistoryView: Bool = false
    
    let backgrounds: Array<String> = ["STR_Img_bg_1_spring", "STR_Img_bg_2_summer", "STR_Img_bg_3_autumn", "STR_Img_bg_4_winter"]
    
    var body: some View {
        let progress = CGFloat.zero
        
        ZStack {
            Image(backgrounds[chapterIndex])
                .resizable()
                .ignoresSafeArea()
            VStack {
                HStack {
                    ViewChangeButton(chapterIndex: $chapterIndex, plantIndex: $plantIndex, postIndex: $postIndex, viewName: $viewName)
                        .environment(\.managedObjectContext, viewContext)
                    
                    Spacer()
                    
                    CustomProgressBar(progress: progress)
                }
                .frame(maxWidth: 360)
                .padding()
                
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
                
                //TODO: AR 버튼 -> AR 뷰 이동 추가
                ZStack {
                    Image(systemName: "cube.transparent")
                        .resizable()
                        .frame(width: 23.87, height: 25.68)
                    Image(systemName: "viewfinder")
                        .resizable()
                        .frame(width: 46.45, height: 46.43)
                }
                .foregroundColor(Color("STR_White"))
            }
        }
    }
}

struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView(chapterIndex: .constant(0), plantIndex: .constant(0), postIndex: .constant(0))
    }
}
