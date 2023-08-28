//
//  OnboardingAftertab.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/15.
//

import SwiftUI

struct OnboardingAftertab: View {
    @ObservedObject var OnboardingViewModel: OnboardingViewModel
    @State private var introIndex = 0
    @State private var isNextView = false
    var accentText: String = "토리의 숲"
    let intro: [String] = ["식물을 키울 준비가 되었나요?\n그럼, 토리의 이름을 알려주세요."]
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
                    
                HStack(alignment: .center) {
                    if introIndex == 0 {
                        let thisIndex = intro[introIndex].firstIndex(of: "토") ?? intro[introIndex].startIndex
                        let otherIndex = intro[introIndex].firstIndex(of: "에") ?? intro[introIndex].endIndex
                            
                        VStack {
                            Text("식물을 키울 준비가 되었나요?")
                                .font(.system(size: 20).weight(.heavy))
                                .foregroundColor(Color("STR_Brown"))
                                .padding(.bottom, 1)
                            
                            HStack {
                                Text(String(intro[introIndex][thisIndex..<otherIndex]))
                                    .font(.system(size: 20).weight(.heavy))
                                    .foregroundColor(Color("STR_Green"))
                                
                                Text(String(intro[introIndex][otherIndex...]))
                                    .font(.system(size: 20).weight(.heavy))
                                    .foregroundColor(Color("STR_Brown"))
                            }
                        }
                        .multilineTextAlignment(.center)
                    }
                        
                }
                Spacer()
            }
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    withAnimation(.linear(duration: 0.5)) {
                        OnboardingViewModel.nextPage()
                    }
                }
            }
    }
}
