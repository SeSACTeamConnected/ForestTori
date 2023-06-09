//
//  ChapterOverView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct ChapterOverView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var chapters: FetchedResults<Chapter>
    
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var missionIndex: Int
    @Binding var postIndex: Int
    @Binding var isChapterCompleted: Bool
    
    @State var isShowGardenView: Bool = false
    
    let chapterImage = ["STR_Img_ChapterThumbnail_1", "STR_Img_ChapterThumbnail_2", "STR_Img_ChapterThumbnail_3", "STR_Img_ChapterThumbnail_4"]
    
    var body: some View {
        VStack {
            Text("챕터 완료!")
                .font(.system(size: 17))
                .fontWeight(.heavy)
                .foregroundColor(Color("STR_Green"))
                .padding(.top, 3)
                .padding(.bottom, 3)
            
            Text(chapters[chapterIndex].chapterHeader!)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(Color("STR_Black"))
                .padding(.bottom, 10)
            
            Image(chapterImage[chapterIndex])
                .resizable()
                .frame(width: 186, height: 186)
                .cornerRadius(8)
                .padding(.bottom, 5)
            
            VStack(alignment: .leading) {
                Text(chapters[chapterIndex].chapterSubHeader!)
                    .font(.system(size: 13, weight: .heavy))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("STR_Brown"))
                    .padding(.horizontal, 25)
                    .padding(.bottom, 1)
                
                Text(chapters[chapterIndex].chapterDescription!)
                    .font(.system(size: 13))
                    .foregroundColor(Color("STR_Black"))
                    .padding(.horizontal, 25)
                    .padding(.bottom, 3)
            }
            
            HStack {
                NavigationLink(
                    destination: GardenView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, missionIndex: $missionIndex, postIndex: $postIndex, isChapterCompleted: $isChapterCompleted)
                        .environment(\.managedObjectContext, viewContext)
                        .navigationBarBackButtonHidden(true)
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("STR_Brown"))
                        Text("정원으로")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color("STR_White"))
                    }
                    .frame(width: 125, height: 35)
                }
                
                Button(action: {
                    isChapterCompleted.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("STR_Brown"))
                        Text("메인으로")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color("STR_White"))
                    }
                    .frame(width: 125, height: 35)
                }
            }
            .padding(.top, 3)
        }
    }
}
