//
//  MessageBox.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct MessageBox: View {
    @State var idx: Int = 0
    
    @Binding var plantStage: Int
    @Binding var chapterID: Int
    @Binding var messages: Message
    @Binding var isMissionCompleted: Bool
    @Binding var isChapterCompleted: Bool
    @Binding var isEmpty: Bool
    @Binding var days: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .opacity(0.2)
            Text(messages.message[idx])
        }
        .padding()
            .onTapGesture {
                idx += 1
                if idx == messages.message.count {
                    self.isMissionCompleted.toggle()
                    idx = 0
                    plantStage += 1
                    if plantStage == days {
                        plantStage = 0
                        isChapterCompleted.toggle()
                        isEmpty.toggle()
                    }
            }
        }
    }
}

struct MessageBox_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
