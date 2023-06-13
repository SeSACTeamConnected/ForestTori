//
//  OnboardingTap.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//

import SwiftUI

struct OnboardingTap: View {
    @ObservedObject var OnboardingViewModel : OnboardingViewModel
    @AppStorage("username") var username: String = ""
    @State var nextPageActive = false
    @State var introIndex = 0
    let intro : [String] = ["빈 화분을 누르면 새로운 퀘스트를 선택해\n 식물을 심을 수 있어요","퀘스트를 완료하고 성장일지를 작성하면,\n식물들이 자라나는 걸 볼 수 있어요","토리의 숲은 계절에 따라 네 챕터가 진행돼요.\n한 챕터당 최대 3개의 화분을 키울 수 있답니다.","한 챕터에서 선택한 모든 미션을 다 끝내면,\n정원에서 내가 키워낸 식물들을 만날 수 있어요.","퀘스트를 열심히 수행하며,\n식물들과 함께 성장해봐요!","첫 챕터는 새로운 시작을 의미하는\n 새싹이 반짝이는 계절, 봄이에요\n 토리의 시작을 응원할게요!"]
    var body: some View {
            ZStack {
                Image("STR_Img_bg_0_default")
                TabView {
                    VStack{
                        OnboardingSkipBtn(OnboardingViewModel: OnboardingViewModel)
                        Image("STR_Img_Tap1")
                            .resizable()
                            .frame(width:324 ,height: 324)
                        
                        HStack(spacing: 0){
                            Text("빈 화분")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Brown"))
                            Text("을 누르면 ")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Black"))
                            Text("새로운 퀘스트")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Brown"))
                            Text("를 선택해")
                                .font(.system(size: 16).weight(.semibold))
                        }
                        Text("식물을 심을 수 있어요")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Black"))
                    }
                    VStack{
                        OnboardingSkipBtn(OnboardingViewModel: OnboardingViewModel)
                        Image("STR_Img_Tap2")
                            .resizable()
                            .frame(width:324 ,height: 324)
                        
                        (Text("퀘스트를 완료하고")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Black"))
                         + Text(" 성장일지")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Brown"))
                         + Text("를 작성하면,\n")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Black"))
                         + Text("식물들이 자라나는 걸 볼 수 있어요.")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Black")))
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                    }

                    VStack{
                        OnboardingSkipBtn(OnboardingViewModel: OnboardingViewModel)
                        Image("STR_Img_Tap3")
                            .resizable()
                            .frame(width:324 ,height: 324)
                       (Text("토리의 숲은")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Black"))
                        + Text(" 계절에 따라 네 챕터")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Brown"))
                        + Text("가 진행돼요.\n한")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Black"))
                        + Text(" 챕터당 최대 3개의 화분")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Brown"))
                        + Text(" 을 키울 수 있답니다.")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color("STR_Black")))
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                    }
                    VStack{
                        OnboardingSkipBtn(OnboardingViewModel: OnboardingViewModel)
                        Image("STR_Img_Tap4")
                            .resizable()
                            .frame(width:324 ,height: 324)
                        if introIndex == 3
                        {
                            let thisIndex = intro[introIndex].firstIndex(of: "미") ?? intro[introIndex].startIndex
                            let otherIndex = intro[introIndex].firstIndex(of: "원") ?? intro[introIndex].endIndex
                            (
                                Text(String(intro[introIndex][..<thisIndex]))
                                    .font(.system(size: 16).weight(.semibold))
                                    .foregroundColor(Color("STR_Black"))
                                + Text(String(intro[introIndex][thisIndex..<otherIndex]))
                                    .font(.system(size: 16).weight(.semibold))
                                    .foregroundColor(Color("STR_Brown"))
                                + Text(String(intro[introIndex][otherIndex...]))
                                    .font(.system(size: 16).weight(.semibold))
                                    .foregroundColor(Color("STR_Black")))
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        }
                    }
                    VStack{
                        OnboardingSkipBtn(OnboardingViewModel: OnboardingViewModel)
                        Image("STR_Img_Tap5")
                            .resizable()
                            .frame(width:324 ,height: 324)
                        if introIndex == 4
                        {
                            let thisIndex = intro[introIndex].firstIndex(of: "식") ?? intro[introIndex].startIndex
                            let otherIndex = intro[introIndex].firstIndex(of: "장") ?? intro[introIndex].endIndex
                            (
                                Text(String(intro[introIndex][..<thisIndex]))
                                    .font(.system(size: 16).weight(.semibold))
                                    .foregroundColor(Color("STR_Black"))
                                + Text(String(intro[introIndex][thisIndex..<otherIndex]))
                                    .font(.system(size: 16).weight(.semibold))
                                    .foregroundColor(Color("STR_Brown"))
                                + Text(String(intro[introIndex][otherIndex...]))
                                    .font(.system(size: 16).weight(.semibold))
                                    .foregroundColor(Color("STR_Black")))
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        }
                    }
                    VStack{
                        OnboardingSkipBtn(OnboardingViewModel: OnboardingViewModel)
                        Image("STR_Img_Tap6")
                            .resizable()
                            .frame(width:324 ,height: 324)
                        HStack(spacing: 0){
                            Text("첫 챕터는 ")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Black"))
                            Text("새로운 시작")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Brown"))
                            Text("을 의미하는")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Black"))
                        }
                        HStack{
                            Text("새싹이 반짝이는 계절,")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Black"))
                            Text("봄")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Brown"))
                            Text("이에요")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color("STR_Black"))
                        }
                        HStack{
                            Text("~~토리의 시작을 응원할게요!")
                        }
                      
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color("STR_Brown"))
                            Text("시작하기")
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
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onAppear {
                    setupAppearance()
                }
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .green.withAlphaComponent(0.6)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}
