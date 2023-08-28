//
//  PlantSelectView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI
import CoreData

struct PlantSelectView: View {
    @Binding var isEmpty: Bool
    @Binding var isShowPlantSelectView: Bool
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var missionIndex: Int
    
    @State var flag = 0
    @State var showingPopup = false
    
    let totalWidth = UIScreen.main.bounds.width * 0.85
    
    var body: some View {
        GeometryReader { _ in
            ScrollViewReader { proxy in
                VStack {
                    Text("식물친구를 선택해 주세요")
                        .foregroundColor(Color("STR_White"))
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<100, id: \.self) { index in
                                                let filteredSelects = Selects.filter { $0.chapter == chapterIndex }
                                                let select = filteredSelects[index % filteredSelects.count]
                                                
                                                PlantCardView(header: select.header, plantName: select.PlantName, imageName: select.imageName, description: select.discription, showingPopup: $showingPopup, isShowPlantSelectView: $isShowPlantSelectView, isEmpty: $isEmpty)
                                                    .padding(.leading, 10)
                                                    .padding(.trailing, 10)
                                                    .padding(.top, 40)
                                                    
                                            }
                                        }
                        .onAppear {
                            flag = 40
                            proxy.scrollTo(flag, anchor: .center)
                            print(chapterIndex)
        
                        }
                    }
                    .scrollDisabled(true)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width > 0 {
                                    if flag >= 1 {
                                        withAnimation(.linear) {
                                            flag -= 1
                                            proxy.scrollTo(flag, anchor: .center)
                                            print(flag)
                                        }
                                    }
                                } else if value.translation.width < 0 {
                                    if flag < 101 {
                                        withAnimation(.linear) {
                                            flag += 1
                                            proxy.scrollTo(flag, anchor: .center)
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
