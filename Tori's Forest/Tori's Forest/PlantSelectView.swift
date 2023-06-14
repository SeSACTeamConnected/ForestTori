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
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<imageNames.count, id: \.self) { index in
                            PlantCardView(header: headers[index], plantName: plantNames[index], imageName: imageNames[index], description: descriptions[index], showingPopup: $showingPopup, isShowPlantSelectView: $isShowPlantSelectView, isEmpty: $isEmpty)
                                .padding(.leading, 10)
                                .padding(.trailing,10)
                        }
                    }
                    .onAppear {
                               withAnimation {
                                   proxy.scrollTo(21, anchor: .center)
                               }
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
//    func createPopup() -> some View {
//        GeometryReader { _ in
//            ScrollViewReader { proxy in
//                ScrollView(.horizontal) {
//                    HStack {
//                        ForEach(0..<imageNames.count, id: \.self) { index in
//                            PlantCardView(header: headers[index], plantName: plantNames[index], imageName: imageNames[index], description: descriptions[index], showingPopup: $showingPopup)
//                                .padding(.leading, 10)
//                                .padding(.trailing,10)
//                        }
//                    }
//                }
//                .scrollDisabled(true)
//                .gesture(
//                    DragGesture()
//                        .onEnded { value in
//                            if value.translation.width > 0 {
//                                if(flag > 1){
//                                    withAnimation(.linear){
//                                        flag -= 1
//                                        proxy.scrollTo(flag,anchor: .center)
//                                        print(flag)
//                                    }
//                                }
//                            }
//                            else if value.translation.width < 0 {
//                                if(flag < 101){
//                                    withAnimation(.linear){
//                                        flag += 1
//                                        proxy.scrollTo(flag,anchor: .center)
//                                        print(flag)
//                                    }
//                                }
//                            }
//                        }
//                )
//            }
//        }
//    }
}

//struct PlantSelectView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @State var snappedItem = 0.0
//    @State var draggingItem = 0.0
//    @State var activeIndex: Int = 0
//
//    @Binding var isEmpty: Bool
//    @Binding var showPlantSelectView: Bool
//
//    @FetchRequest(sortDescriptors: [])
//    var plants: FetchedResults<Plant>
//
//    @FetchRequest(sortDescriptors: [])
//    var missions: FetchedResults<Mission>
//
//    var chapterIndex: Int
//    var plantIndex: Int
//    var missionIndex: Int
//
//    let imageDefault: String = "STR_Img_PlantSelect"
//    let fourSeasons: Array<String> = ["Spring", "Summer", "Autumn", "Winter"]
//
//    var body: some View {
//        let season: String = fourSeasons[chapterIndex]
//        let range: Range = season == "Winter" ? 0..<7 : 0..<5
//        let imageDefaultWithSeason = imageDefault + "_" + season
//
//        ZStack {
//            ForEach(range) { idx in
//                VStack {
//                    Text("식물 친구를 선택해 주세요.")
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(.gray)
//                        VStack {
//                            if idx == 0 {
//                                Text(missions[missionIndex].missionHeader!)
//                                Text(plants[Int(missions[missionIndex].plantID)-1].plantName!)
//                            }else {
//                                Text("미션 제목")
//                                Text("???")
//                            }
//
//                            Image(imageDefaultWithSeason+"_"+String(idx+1))
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 264, height: 209)
//                                .cornerRadius(8)
//
//                            if idx == 0 {
//                                Text(plants[Int(missions[missionIndex].plantID)-1].plantDescription!)
//                            } else {
//                                Text("[곧 만나볼 수 있어요.]")
//                            }
//
//                            Button {
//                                print("Plant is selected")
//                                self.isEmpty.toggle()
//                                self.showPlantSelectView.toggle()
//                            } label: {
//                                Text("선택하기")
//                            }
//                        }
//                        .padding()
//                    }
//                    .frame(width: 300, height: 300)
//                    .scaleEffect(1.0 - abs(distance(idx)) * 0.2)
//                    .opacity(1.0 - abs(distance(idx)) * 0.5 )
//                    .offset(x: myXOffset(idx), y: 0)
//                    .zIndex(1.0 - abs(distance(idx)) * 0.1)
//                    .onTapGesture {
//                        withAnimation {
//                            draggingItem = Double(idx)
//                        }
//                    }
//                }
//            }
//        }
//        .gesture(getDragGesture())
//    }
//    private func getDragGesture() -> some Gesture {
//            DragGesture()
//                .onChanged { value in
//                    draggingItem = snappedItem + value.translation.width / 100
//                }
//                .onEnded { value in
//                    withAnimation {
//                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
//                        draggingItem = round(draggingItem).remainder(dividingBy: Double(plants.count))
//                        snappedItem = draggingItem
//
//                        self.activeIndex = plants.count + Int(draggingItem)
//                        if self.activeIndex > plants.count || Int(draggingItem) >= 0 {
//                            self.activeIndex = Int(draggingItem)
//                }
//            }
//        }
//    }
//
//    func distance(_ item: Int) -> Double {
//        return (draggingItem + Double(item)).remainder(dividingBy: Double(plants.count))
//    }
//
//    func myXOffset(_ item: Int) -> Double {
//        let angle = Double.pi * 2 / Double(plants.count) * distance(item)
//        return sin(angle) * 300
//    }
//}
//
//struct PlantSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
