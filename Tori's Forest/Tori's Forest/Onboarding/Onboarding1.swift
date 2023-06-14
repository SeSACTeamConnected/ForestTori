//
//  Onboarding1.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//

import SwiftUI

struct Onboarding1: View {
    @ObservedObject var OnboardingViewModel : OnboardingViewModel
    @State private var introIndex = 0
    @State private var isNextView = false
    var accentText : String = "토리의 숲"
    let intro : [String] = ["반가워요,\n토리의 숲에 오신걸 환영해요!","저는 문지기 요정 프리지아에요\n토리의 이름은 무엇인가요?"]
    var body: some View {
        ZStack{
            Image("STR_Img_bg_0_default")
                .resizable()
                .ignoresSafeArea()
                
            VStack(alignment: .center) {
                Image("STR_Img_Onboarding_frezia")
                    .resizable()
                    .frame(width: 347,height: 195)
                    .padding(.bottom,20)
                    
                HStack(alignment: .center){
                    if(introIndex == 0){
                        let thisIndex = intro[introIndex].firstIndex(of: "토") ?? intro[introIndex].startIndex
                        let otherIndex = intro[introIndex].firstIndex(of: "에") ?? intro[introIndex].endIndex
                            (
                            Text(String(intro[introIndex][..<thisIndex]))
                                .font(.system(size: 20).weight(.heavy))
                                .foregroundColor(Color("STR_Brown"))
                            + Text(String(intro[introIndex][thisIndex..<otherIndex]))
                                .font(.system(size: 20).weight(.heavy))
                                .foregroundColor(Color("STR_Green"))
                            + Text(String(intro[introIndex][otherIndex...]))
                                .font(.system(size: 20).weight(.heavy))
                                .foregroundColor(Color("STR_Brown")))
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                    }
                    else{
                        Text(intro[introIndex])
                            .font(.system(size: 20).weight(.heavy))
                            .frame(alignment: .center)
                            .foregroundColor(Color("STR_Brown"))
                            .multilineTextAlignment(.center)
                            
                            
                    }
                        
                }
                .frame(alignment: .center)
                .padding(.bottom, 100)
            }
        }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    withAnimation(.linear(duration: 0.5)){
                        self.introIndex = 1
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
                    withAnimation(.linear(duration: 0.5)){
                        OnboardingViewModel.nextPage()
                    }
                }
            }
    }
}



 
