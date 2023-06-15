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
    
    
    var body: some View {
        if maximum == 3 {
            let progress = CGFloat(plants[missionIndex].level - 1) / CGFloat(maximum)
            let percent = Int(1 + progress * 100)
            
            ZStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 15)
                    //                    .frame(width: 110, height: 50)
                        .foregroundColor(Color("STR_Black").opacity(0.3))
                        .frame(width: 130, height: 50)
                    
                    RoundedRectangle(cornerRadius: 15)
                    //                    .frame(width: 110, height: 50)
                        .foregroundColor(Color("STR_Brown").opacity(0.3))
                    //                    .scaleEffect(x: progress, y: 1.0, anchor: .leading)
                        .frame(width: progress == 1 ? 130 : (130 * progress), height: 50)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("STR_White"), lineWidth: 2)
                        .frame(width: 130, height: 50)
                }
                
                //글씨색 수정필요\(
                Text("\(plants[missionIndex].plantName!)\n\(percent >= 100 ? 100 : percent)%")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color("STR_White"))
                    .font(.system(size: 18))
            }
        } else {
            let progress = CGFloat(missions[missionIndex].plantID - 1) / CGFloat(maximum)
            let percent = Int(1 + progress * 100)
            ZStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 15)
                    //                    .frame(width: 110, height: 50)
                        .foregroundColor(Color("STR_Black").opacity(0.3))
                        .frame(width: 241, height: 50)
                    
                    RoundedRectangle(cornerRadius: 15)
                    //                    .frame(width: 110, height: 50)
                        .foregroundColor(Color("STR_White").opacity(0.5))
                    //                    .scaleEffect(x: progress, y: 1.0, anchor: .leading)
                        .frame(width: progress == 1 ? 241 : (241 * progress), height: 50)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("STR_White"), lineWidth: 2)
                        .frame(width: 241, height: 50)
                }
                
                Text("\(chapters[Int(missions[missionIndex].chapterID) - 1].chapterSubHeader!)\n\(percent >= 100 ? 100 : percent)%")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color("STR_White"))
                    .shadow(radius: 1)
                    .font(.system(size: 18))
            }
        }
    }
}
