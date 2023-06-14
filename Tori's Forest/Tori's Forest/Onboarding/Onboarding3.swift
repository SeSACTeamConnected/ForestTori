//
//  Onboarding3.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//

import SwiftUI

struct Onboarding3: View {
    var description: [String] = ["멋진 이름이네요", "이 숲 속의 반짝이는 무언가를 찾으면\n 훌륭한 요정이 될 수 있을 거에요"]
    @State var introIndex = 0
    @State var isNextView = false
    @ObservedObject var OnboardingViewModel : OnboardingViewModel
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        ZStack {
                Image("STR_Img_bg_0_default")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Image("STR_Img_Onboarding_frezia")
                        .resizable()
                        .frame(width: 347, height: 195)
                    if introIndex == 0 {
                        Text(description[introIndex])
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("STR_brown"))
                        Text(username)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("STR_Green"))
                    }
                    else if introIndex == 1 {
                        HStack(spacing: 0){
                            Text("여기 ")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("STR_brown"))
                            Text(username)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("STR_Green"))
                            Text("를 위해")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("STR_brown"))
                        }
                        Text("신비한 화분을 줄게요")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("STR_brown"))
                    }
                    else if introIndex == 2{
                        HStack(spacing: 0){
                            Text("이제부터")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("STR_brown"))
                            Text( username)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("STR_Green"))
                        }
                        Text("마법 능력으로 식물을 잘 키워주세요")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("STR_brown"))
                    }
                }
                .onAppear {
                               withAnimation(.linear(duration: 2.0)) {
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                       introIndex = 1
                                   }
                               }
                               withAnimation(.linear(duration: 4.0)) {
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                       introIndex = 2
                                   }
                               }
                               withAnimation(.linear(duration: 2.0)) {
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                       OnboardingViewModel.nextPage()
                                   }
                               }
                           }
        }
    }
}

