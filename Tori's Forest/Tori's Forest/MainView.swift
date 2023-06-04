//
//  MainView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct MainView: View {
    @State var chapterID: Int = 0
    @State var chapters: Array<Chapter> = ChapterStore.shared.chapters

    var body: some View {
        TabView {
            PlantPotView(chapterID: $chapterID, plants: $chapters[chapterID].plants, days: $chapters[chapterID].days)
                .tabItem {
                    Text("식물1")
                }
            
            PlantPotView(chapterID: $chapterID, plants: $chapters[chapterID].plants, days: $chapters[chapterID].days)
                .tabItem {
                    Text("식물2")
                }
            
            PlantPotView(chapterID: $chapterID, plants: $chapters[chapterID].plants, days: $chapters[chapterID].days)
                .tabItem {
                    Text("식물3")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
