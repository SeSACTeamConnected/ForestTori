//
//  MissionBox.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct MissionBox: View {
    @State var idx: Int = 0
    @Binding var mission: String
    @Binding var isMissionCompleted: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .opacity(0.2)
            Text(mission)
        }
        .padding()
        .onTapGesture {
            isMissionCompleted.toggle()
        }
    }
}


struct MissionBox_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
