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
                            .foregroundColor(Color("STR_Brown"))
                        Text(username)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("STR_Green"))
                    } else {
                        let thisIndex = description[introIndex].firstIndex(of: "반") ?? description[introIndex].startIndex
                        let otherIndex = description[introIndex].firstIndex(of: "를") ?? description[introIndex].endIndex
                        (
                            Text(String(description[introIndex][..<thisIndex]))
                                .font(.system(size: 20).weight(.heavy))
                                .foregroundColor(Color("STR_Brown"))
                            + Text(String(description[introIndex][thisIndex..<otherIndex]))
                                .font(.system(size: 20).weight(.heavy))
                                .foregroundColor(Color("STR_Green"))
                            + Text(String(description[introIndex][otherIndex...]))
                                .font(.system(size: 20).weight(.heavy))
                                .foregroundColor(Color("STR_Brown"))
                        )
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                    }
                    if introIndex == 1 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color("STR_Brown"))
                            Text("이름 알려주기")
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        .onTapGesture {
                            OnboardingViewModel.nextPage()
                        }
                    }
                }
                .onAppear {
                    withAnimation(.linear(duration: 2.0)) {
                        if introIndex == 0 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.linear(duration: 0.5)) {
                                    introIndex = 1
                                }
                            }
                        }
                    }
                }
        }
    }
}

