//
//  PlantHistoryView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct History: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let day: String
}

struct PlantHistoryView: View {
    let listItems = [
        History(image: "test", title: "Day01", day: "2023.06.04"),
        History(image: "test", title: "Day02", day: "2023.06.05"),
        History(image: "test", title: "Day03", day: "2023.06.06")
    ]
    
    @Binding var collectedPlantName: String
    @Binding var collectedPlantImage: String
    @Binding var collectedPlantDetail: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text(collectedPlantName)
                Image(collectedPlantImage)
                Text(collectedPlantDetail)
                LazyVStack {
                    ForEach(listItems) { item in
                        HStack {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            VStack {
                                Text(item.title)
                                Text(item.day)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct PlantHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView()
    }
}
