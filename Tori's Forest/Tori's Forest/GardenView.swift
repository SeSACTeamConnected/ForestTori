//
//  GardenView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct GardenView: View {
    @State var viewName: String = "Garden"
    @State var messages: Array<String> = ["오랜만이야", "잘 지냈어?"]
    @State var showPlantHistoryView: Bool = false
    @State var collectedPlantNames: Array<String> = ["식물1", "식물2", "식물3", "식물4"]
    @State var collectedPlantImages: Array<String> = ["test", "test", "test", "test"]
    @State var collectedPlantDetails: Array<String> = ["식물1 설명", "식물2 설명", "식물3 설명", "식물4 설명"]
    var body: some View {
        VStack {
            HStack {
                ViewChangeButton(viewName: $viewName)
                Spacer()
                Text("프로그레스")
            }
            .padding()
            Image("test")
                .onTapGesture {
                    self.showPlantHistoryView.toggle()
                }
                .sheet(isPresented: self.$showPlantHistoryView) {
                    PlantHistoryView(collectedPlantName: $collectedPlantNames[0], collectedPlantImage: $collectedPlantImages[0], collectedPlantDetail: $collectedPlantDetails[0])
                }
//            MessageBox(messages: $messages)
        }
    }
}

struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView()
    }
}
