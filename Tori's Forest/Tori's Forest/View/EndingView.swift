//
//  EndingView.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/15.
//

import SwiftUI

struct EndingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var missionIndex: Int
    @Binding var postIndex: Int
    
    @State private var introIndex = 0
    @State private var isNextView = false
    
    var accentText: String = "토리의 숲"
    
    @AppStorage("username") var username: String = ""
    
    let intro: [String] = ["반가워요,\n토리의 숲에 오신걸 환영해요!", "저는 문지기 요정 프리지아에요\n토리의 숲을 안내해 드릴게요?"]
    
    var body: some View {
        ZStack {
            Image("STR_Img_bg_0_default")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                
                Image("STR_Img_Onboarding_frezia")
                    .resizable()
                    .frame(width: 347, height: 195)
                    .padding(.bottom, 20)
                
                if introIndex == 0 {
                    Text(username+"토리,")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Green"))
                        .padding(.bottom, 1)
                    
                    Text("오랜만이에요.")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .padding(.bottom, 1)
                    
                }
                
                else if introIndex == 1 {
                    Text("정말 열심히 식물을 키워주었군요!")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    
                    Text("정원이 예쁜 식물들로 가득해졌네요.")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                }
                
                else if introIndex == 2 {
                    
                    Text("그런데, 여길 봐요!")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    
                    Text("방금 새 싹을 틔운 화분 하나가 남아있어요.")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                }
                
                
                else if introIndex == 3 {
                    Text("사실, 이 새싹은 바로")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .padding(.bottom, 1)
                    
                    HStack(spacing: 0){
                        Text(username+"토리,")
                            .font(.system(size: 20).weight(.heavy))
                            .foregroundColor(Color("STR_Green"))
                        
                        Text(" 당신이에요.")
                            .font(.system(size: 20).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                    }
                }
                
                else if introIndex == 4 {
                    Text("이제는 토리의 숲을 벗어나")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    
                    Text("더 넓은 세상에서 자라날 준비가 된 것 같네요.")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                }
                
                else if introIndex == 5 {
                    
                    Text("토리의 숲이 그리워질 때면,")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    
                    Text("언제든 다시 찾아와요.")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    
                }
                
                Spacer()
                
                NavigationLink(
                    destination:
                        GardenView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, missionIndex: $missionIndex, postIndex: $postIndex, isChapterCompleted: .constant(false))
                        .environment(\.managedObjectContext, viewContext)
                        .navigationBarBackButtonHidden(true)
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("STR_Brown"))
                        Text("좋아요")
                            .font(.system(size: 18).weight(.bold))
                            .foregroundColor(Color("STR_White"))
                    }
                    .frame(width: 342, height: 60)
                    .opacity(introIndex == 4 ? 1 : 0)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                withAnimation(.linear(duration: 0.5)) {
                    self.introIndex = 1
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
                withAnimation(.linear(duration: 0.5)) {
                    self.introIndex = 2
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
                withAnimation(.linear(duration: 0.5)) {
                    self.introIndex = 3
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8) {
                withAnimation(.linear(duration: 0.5)) {
                    self.introIndex = 4
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 12) {
                withAnimation(.linear(duration: 0.5)) {
                    self.introIndex = 5
                }
            }
        }
    }
}
