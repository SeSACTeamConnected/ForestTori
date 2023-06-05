//
//  ChapterOverView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct ChapterOverView: View {
    @Binding var chapterID: Int
    @Binding var isChapterCompleted: Bool
    
    var body: some View {
        VStack {
            Text("챕터 완료!")
            Image("test")
            Text("챕터 완료, 다음 챕터로 이동")
            HStack {
                Button {
                    chapterID += 1
                    isChapterCompleted.toggle()
                } label: {
                    Text("정원으로")
                }
                Button {
                    chapterID += 1
                    isChapterCompleted.toggle()
                } label: {
                    Text("메인으로")
                }
            }
        }
    }
}

struct ChapterOverView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
