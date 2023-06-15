//
//  Onboarding1.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//

import SwiftUI

struct Onboarding1: View {
    @ObservedObject var OnboardingViewModel: OnboardingViewModel
    @State private var introIndex = 0
    @State private var isNextView = false
    var accentText: String = "토리의 숲"
    let intro: [String] = ["반가워요,\n토리의 숲에 오신걸 환영해요!", "저는 문지기 요정 프리지아에요.\n토리의 숲을 안내해 드릴게요?"]
    
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
                    .padding()
                
                if introIndex == 0 {
                    let thisIndex = intro[0].firstIndex(of: "토") ?? intro[introIndex].startIndex
                    let otherIndex = intro[0].firstIndex(of: "에") ?? intro[introIndex].endIndex
                    
                    (Text(String(intro[introIndex][..<thisIndex]))
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                     
                     + Text(String(intro[introIndex][thisIndex..<otherIndex]))
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Green"))
                     
                     + Text(String(intro[introIndex][otherIndex...]))
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown")))
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                } else {
                    
                    Text("저는 문지기 요정, 프리지아에요.")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Brown"))
                    
                    HStack(spacing: 0) {
                        Text("토리의 숲")
                            .font(.system(size: 20).weight(.heavy))
                            .foregroundColor(Color("STR_Green"))
                        Text("을 안내해드릴게요.")
                            .font(.system(size: 20).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                    }
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    
                }
                
                Button(action: {
                    OnboardingViewModel.nextPage()
                }) {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("STR_Brown"))
                        Text("좋아요")
                            .font(.system(size: 18).weight(.bold))
                            .foregroundColor(Color("STR_White"))
                    }
                    .frame(width: 342, height: 60)
                    
                }
                .opacity(introIndex == 0 ? 0 : 1)
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                withAnimation(.linear(duration: 0.5)) {
                    self.introIndex = 1
                }
            }
        }
    }
}
