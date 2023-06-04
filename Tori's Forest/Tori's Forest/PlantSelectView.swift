//
//  PlantSelectView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct PlantSelectView: View {
    @State var snappedItem = 0.0
    @State var draggingItem = 0.0
    @State var activeIndex: Int = 0
    @Binding var isEmpty: Bool
    @Binding var showPlantSelectView: Bool
    @Binding var plants: Array<Plant>
    @Binding var plantIndex: Int

    var body: some View {
        ZStack {
            ForEach(0..<plants.count) { idx in
                VStack {
                    Text("식물 친구를 선택해 주세요.")
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                        VStack {
                            Text(plants[idx].name)
                            Image("test")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text(plants[idx].detail)
                            Button {
                                print("Plant is selected")
                                self.plantIndex = plants[idx].id
                                self.isEmpty.toggle()
                                self.showPlantSelectView.toggle()
                            } label: {
                                Text("선택")
                            }
                        }
                        .padding()
                    }
                    .frame(width: 300, height: 300)
                    .scaleEffect(1.0 - abs(distance(idx)) * 0.2)
                    .opacity(1.0 - abs(distance(idx)) * 0.5 )
                    .offset(x: myXOffset(idx), y: 0)
                    .zIndex(1.0 - abs(distance(idx)) * 0.1)
                    .onTapGesture {
                        withAnimation {
                            draggingItem = Double(idx)
                        }
                    }
                }
            }
        }
        .gesture(getDragGesture())
    }
    private func getDragGesture() -> some Gesture {
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(plants.count))
                        snappedItem = draggingItem
                        
                        self.activeIndex = plants.count + Int(draggingItem)
                        if self.activeIndex > plants.count || Int(draggingItem) >= 0 {
                            self.activeIndex = Int(draggingItem)
                }
            }
        }
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem + Double(item)).remainder(dividingBy: Double(plants.count))
    }
        
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(plants.count) * distance(item)
        return sin(angle) * 300
    }
}

struct PlantSelectView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
