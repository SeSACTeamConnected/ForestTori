//
//  MessageBox.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI
import WatchConnectivity

struct MessageBox: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @EnvironmentObject var onboardingViewModel : OnboardingViewModel
    
    @ObservedObject var model = ViewModelPhone()
    
    @FetchRequest(sortDescriptors: [])
    var dialogs: FetchedResults<Dialog>
    
    @FetchRequest(sortDescriptors: [])
    var missions: FetchedResults<Mission>

//    @AppStorage("dialogIndex") var dialogIndex: Int = 0
//    @AppStorage("chapterIndex") var chapterIndex: Int = 0

    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var dialogIndex: Int
    @Binding var missionIndex: Int
    @Binding var isEmpty: Bool
    @Binding var isMissionCompleted: Bool
    @Binding var isChapterCompleted: Bool
    @Binding var isAllChapterCompleted: Bool

    var body: some View {
//        let username = onboardingViewModel.username
        
        ZStack {
            Image("STR_Img_asset_frame_dialog")
                .resizable()
                .frame(width: 342, height: 100)
                .offset(y: 10)
            
            if let username = UserDefaults.standard.string(forKey: "username") {
                    Text(dialogs[dialogIndex].dialogLine!.replacingOccurrences(of: "(username)", with: username))
                        .font(.system(size: 16))
                        .foregroundColor(Color("STR_Black"))
                        .padding(.horizontal, 20)
                        .frame(width: 342, height: 59, alignment: .leading)
                        .lineSpacing(1)
            }
            
            Image("STR_Img_asset_button_dialog")
                .resizable()
                .frame(width: 15, height: 10)
                .offset(x: 150, y: 23)
            }
        .frame(width: 342, height: 72)
        .padding()
        .onTapGesture {
            dialogIndex += 1
            
            let nextMission = dialogs[dialogIndex].missionID
            if (missionIndex + 1) < nextMission {
                isMissionCompleted.toggle()
                missionIndex += 1
                plantIndex += 1
                print(plantIndex)
            }
            if (chapterIndex + 1) < missions[missionIndex].chapterID {
                chapterIndex += 1
                if chapterIndex > 3 {
                    isAllChapterCompleted = true
                }
                
                if chapterIndex == 3 {
                    self.model.sendMessageToWatch(message: [
                        "목화나무": "봉사활동 도전하기",
                        "???": "도서관에서 책 읽고 오기",
                        "????": "산책 20분 하고 오기"
                    ])
                }
                isEmpty.toggle()
                isChapterCompleted.toggle()
//                chapterIndex = min(chapterIndex, 3)
            }
        }
    }
}
//
// struct MessageBox_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
// }
