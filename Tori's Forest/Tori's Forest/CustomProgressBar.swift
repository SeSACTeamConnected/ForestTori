//
//  CustomProgressBar.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct CustomProgressBar: View {
    @FetchRequest(sortDescriptors: [])
    var chapters: FetchedResults<Chapter>
    
    @FetchRequest(sortDescriptors: [])
    var plants: FetchedResults<Plant>
    
    @FetchRequest(sortDescriptors: [])
    var missions: FetchedResults<Mission>
    
    @Binding var missionIndex: Int
    @Binding var maximum: Int
    @Binding var isDone: Bool
    
    @State var seasons = ["spring", "summer", "autumn", "winter"]
    
    var body: some View {
        if maximum == 3 {
            if !isDone {
                let progress = CGFloat(plants[missionIndex].level - 1) / CGFloat(maximum)
                let percent = Int(1 + progress * 100)
                
                ZStack {
                    Image("STR_Img_progress_pot_\(plants[missionIndex].level)")
                    
                    Text("\(plants[missionIndex].plantName!)\n\(percent >= 100 ? 100 : percent)%")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color("STR_White"))
                        .font(.system(size: 18))
                }
            } else {
                let progress = CGFloat(plants[missionIndex].level) / CGFloat(maximum)
                let percent = Int(1 + progress * 100)
                
                ZStack {
                    Image("STR_Img_progress_pot_\(plants[missionIndex].level+1)")
                    
                    Text("\(plants[missionIndex].plantName!)\n\(percent >= 100 ? 100 : percent)%")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color("STR_White"))
                        .font(.system(size: 18))
                }
            }
        } else {
            if !isDone {
                let progress = CGFloat(missionIndex) / CGFloat(maximum)
                let percent = Int(1 + progress * 100)
                
                ZStack {
                    Image("STR_Img_progress_garden_\(seasons[Int(missions[missionIndex].chapterID)-1])_\(plants[missionIndex].level)")
                    
                    Text("\(chapters[Int(missions[missionIndex].chapterID)-1].chapterSubHeader!)\n\(percent >= 100 ? 100 : percent)%")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color("STR_White"))
                        .font(.system(size: 18))
                }
            } else {
                let progress = CGFloat(missionIndex+1) / CGFloat(maximum)
                let percent = Int(1 + progress * 100)
                
                ZStack {
                    Image("STR_Img_progress_garden_\(seasons[Int(missions[missionIndex].chapterID)])_\(plants[missionIndex].level)")
                    
                    Text("\(chapters[Int(missions[missionIndex].chapterID)-1].chapterSubHeader!)\n\(percent >= 100 ? 100 : percent)%")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color("STR_White"))
                        .font(.system(size: 18))
                }
            }
        }
    }
}
