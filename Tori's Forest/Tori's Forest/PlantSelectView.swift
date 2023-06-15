//
//  PlantSelectView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI
import CoreData
import PopupView

struct PlantSelectView: View {
    @Binding var isEmpty: Bool
    @Binding var isShowPlantSelectView: Bool
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var missionIndex: Int
    
    @State var flag = 0
    
    var imageNames: [String] = {
        let baseArray = ["STR_Img_PlantSelect_Spring_1", "STR_Img_PlantSelect_Spring_2", "STR_Img_PlantSelect_Spring_3", "STR_Img_PlantSelect_Spring_4", "STR_Img_PlantSelect_Spring_5"]
        return Array(repeating: baseArray, count: 100).flatMap { $0 }
    }()
    
    var plantNames: [String] = {
        let baseArray = ["민들레씨", "???", "???", "???", "???"]
        return Array(repeating: baseArray, count: 100).flatMap { $0 }
    }()
    
    var headers: [String] = {
        let baseArray = ["매일 창문 30분 열어 환기하기", "양치하기", "일어나자마자 이불 정리하기", "하루에 한번 샤워하기", "방청소 하기"]
        return Array(repeating: baseArray, count: 100).flatMap { $0 }
    }()
    
    var descriptions: [String] = {
        let baseArray = ["겁이 많은 민들레씨들이 하늘로 날아가지 못하고 있어요. 용기를 낼 수 있게 매일 창문을 열어 민들레씨들을 도와줄래요?", "곧 만나볼 수 있어요.", "곧 만나볼 수 있어요.", "곧 만나볼 수 있어요.", "곧 만나볼 수 있어요."]
        return Array(repeating: baseArray, count: 100).flatMap { $0 }
    }()
    
    @State var showingPopup = false
    
    let totalWidth = UIScreen.main.bounds.width * 0.85
    
    var body: some View {
        GeometryReader { _ in
            ScrollViewReader { proxy in
                VStack {
                    Text("식물친구를 선택해 주세요.")
                        .foregroundColor(Color("STR_White"))
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<imageNames.count, id: \.self) { index in
                                PlantCardView(header: headers[index], plantName: plantNames[index], imageName: imageNames[index], description: descriptions[index], showingPopup: $showingPopup, isShowPlantSelectView: $isShowPlantSelectView, isEmpty: $isEmpty)
                                    .padding(.leading, 10)
                                    .padding(.trailing,10)
                            }
                        }
                        .onAppear {
                            
                            proxy.scrollTo(20, anchor: .center)
                            flag = 20
                        }
                    }
                    .scrollDisabled(true)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width > 0 {
                                    if(flag >= 1){
                                        withAnimation(.linear){
                                            flag -= 1
                                            proxy.scrollTo(flag,anchor: .center)
                                            print(flag)
                                        }
                                    }
                                }
                                else if value.translation.width < 0 {
                                    if(flag < 101){
                                        withAnimation(.linear){
                                            flag += 1
                                            proxy.scrollTo(flag,anchor: .center)
                                            print(flag)
                                    }
                                }
                            }
                        }
                    )
                }
            }
        }
    }
}

