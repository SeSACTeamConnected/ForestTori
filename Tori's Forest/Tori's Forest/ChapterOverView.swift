//
//  ChapterOverView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct ChapterOverView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: [])
    var chapters: FetchedResults<Chapter>
    
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
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
                .padding(3)
            Text(chapters[chapterIndex].chapterHeader!)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(Color("STR_Black"))
                .padding(3)
            Image(chapterImage[chapterIndex])
                .resizable()
                .frame(width: 186, height: 186)
            Text(chapters[chapterIndex].chapterSubHeader!)
                .font(.system(size: 13))
                .fontWeight(.semibold)
                .foregroundColor(Color("STR_Brown"))
            Text(chapters[chapterIndex].chapterDescription!)
                .font(.system(size: 13))
                .foregroundColor(Color("STR_Black"))
                .padding(.horizontal, 30)
            
            HStack {
                NavigationLink(
                    destination: GardenView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, postIndex: $postIndex)
                        .environment(\.managedObjectContext, viewContext)
                        .navigationBarBackButtonHidden(true)
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("STR_Brown"))
                        Text("정원으로")
                            .foregroundColor(Color("STR_White"))
                    }
                    .frame(width: 125, height: 35)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("STR_Brown"))
                        Text("메인으로")
                            .foregroundColor(Color("STR_White"))
                    }
                    .frame(width: 125, height: 35)
                }
            }
        }
    }
        
}
