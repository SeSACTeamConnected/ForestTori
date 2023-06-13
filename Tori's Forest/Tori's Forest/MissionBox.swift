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
    
    @State var circleName: String = "circle"
    @State var circleColor: String = "STR_Brown"
    @State var circleOpacity: Double = 0.15
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(.white)
            
            HStack {
                Text(missions[missionIndex].missionDescription!)
                    .font(.system(size: 18))
                    .foregroundColor(Color("STR_Brown"))
                    .fontWeight(.bold)

                Spacer()

                Image(systemName: circleName)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .foregroundColor(Color(circleColor))
                    .opacity(circleOpacity)
                    .onTapGesture {
                        circleName = "checkmark.circle.fill"
                        circleColor = "STR_Green"
                        circleOpacity = 1
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
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

//struct MissionBox_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
