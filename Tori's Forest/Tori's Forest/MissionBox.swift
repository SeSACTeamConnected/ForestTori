//
//  MissionBox.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct MissionBox: View {
    @FetchRequest(sortDescriptors: [])
    private var missions: FetchedResults<Mission>
    
    @Binding var isShowDiaryView: Bool
    @Binding var isMissionCompleted: Bool
    @Binding var missionIndex: Int
    @Binding var isTapped: Bool
    
    var body: some View {
        let circleName: String = isTapped ? "checkmark.circle.fill" : "circle"
        let circleColor: String = isTapped ? "STR_Green" : "STR_brown"
        let circleOpacity: Double = isTapped ? 1 : 0.15
        
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(.white)
            
            HStack {
                Text(missions[missionIndex].missionDescription!)
                    .font(.system(size: 18))
                    .foregroundColor(Color("STR_brown"))
                    .fontWeight(.bold)

                Spacer()

                Image(systemName: circleName)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .foregroundColor(Color(circleColor))
                    .opacity(circleOpacity)
                    .onTapGesture {
                        isTapped = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            isShowDiaryView.toggle()
                        }
                    }
            }
            .padding(.leading, 30)
            .padding(.trailing, 20)
        }
        .frame(width: 342, height: 68)
        .padding(.bottom, 20)
    }
}
