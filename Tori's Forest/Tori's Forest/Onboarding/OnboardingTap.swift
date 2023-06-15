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
    let intro : [String] = ["나만의 화분에서 특별한 식물 친구를 키워봐요!\n빈 화분을 누르면 원하는 퀘스트를 선택해 식물로 심을 수 있어요.","나의 뿌듯한 마음을 기록하는 성장일지를 작성해 퀘스트를 완료해보세요.","퀘스트를 완료하면,\n식물들도 함께 성장하는 걸 볼 수 있어요..","토리의 숲은 계절에 따라 네 챕터가 진행돼요.\n한 챕터 당 최대 3개의 화분까지 키울 수 있답니다.","한 챕터에서 선택한 모든 미션을 다 끝내면, 정원에서 내가 키워낸 식물들을 만날 수 있어요.","열심히 가꾼 정원은 AR로 띄울 수 있어요.\n나만의 공간에서 식물들과 함꼐해요!"]
    var body: some View {
        ZStack {
            Image("STR_Img_bg_0_default")
            
            TabView {
                VStack(spacing: 5) {
                    Image("STR_Img_Tap1")
                        .resizable()
                        .frame(width:324 ,height: 324)
                        .padding(.bottom)
                    
                    HStack(spacing: 0) {
                        Text("나만의 화분에서")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                        Text(" 특별한 식물 친구")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("를 키워봐요!")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                    
                    HStack(spacing: 0) {
                        Text("빈 화분")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("을 누르면 ")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                        Text("원하는 퀘스트")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("를 선택해")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                    
                    Text("식물을 심을 수 있어요.")
                        .font(.system(size: 16))
                        .foregroundColor(Color("STR_Black"))
                }
  
                VStack(spacing: 5){
                    Image("STR_Img_Tap2")
                        .resizable()
                        .frame(width:324 ,height: 324)
                        .padding(.bottom)
                    
                    HStack(spacing: 0) {
                        Text("나의 ")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                        Text("뿌듯한 마음")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("을 기록하는 ")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                        Text("성장일지")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("를 작성해")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                    
                    HStack(spacing: 0) {
                        Text("퀘스트를 완료해 보세요.")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                }
                
                VStack(spacing: 5) {
                    Image("STR_Img_Tap3")
                        .resizable()
                        .frame(width:324 ,height: 324)
                        .padding(.bottom)
                    
                    Text("퀘스트를 완료하면,")
                        .font(.system(size: 16))
                        .foregroundColor(Color("STR_Black"))
                    
                    HStack(spacing: 0) {
                        Text("식물들도 함께 성장")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("하는 걸 볼 수 있어요.")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                    
                }
                
                VStack(spacing: 5) {
                    Image("STR_Img_Tap4")
                        .resizable()
                        .frame(width:324 ,height: 324)
                        .padding(.bottom)
                    
                    HStack(spacing: 0) {
                        Text("토라의 숲은")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                        Text(" 계절에 따라 네 챕터")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("가 진행돼요.")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                    
                    HStack(spacing: 0) {
                        Text("한")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                        Text(" 챕터 당 최대 3개의 화분까지")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("키울 수 있답니다.")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                }
                
                VStack(spacing: 5) {
                    Image("STR_Img_Tap5")
                        .resizable()
                        .frame(width:324 ,height: 324)
                        .padding(.bottom)
                    
                    HStack(spacing: 0) {
                        Text("한 챕터에서 선택한 모든 ")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                        Text("미션을 다 끝내면,")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                    }
                    
                    HStack(spacing: 0) {
                        Text("정원")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("에서 내가 키워낸 식물들을 만날 수 있어요.")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                }
                
                VStack(spacing: 5                                                                                                                                                                                                                                                                                                                                                                                                                                  ) {
                    Image("STR_Img_Tap6")
                        .resizable()
                        .frame(width:324 ,height: 324)
                        .padding(.bottom)
                    
                    HStack(spacing: 0){
                        Text("열심히 가꾼 정원은 ")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                        Text("AR")
                            .font(.system(size: 16).weight(.heavy))
                            .foregroundColor(Color("STR_Brown"))
                        Text("로 띄울 수 있어요.")
                            .font(.system(size: 16))
                            .foregroundColor(Color("STR_Black"))
                    }
                    
                    Text("나만의 공간에서 식물들과 함께 해요!")
                        .font(.system(size: 16))
                        .foregroundColor(Color("STR_Black"))
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color("STR_Brown"))
                        Text("준비됐어요")
                            .font(.system(size: 18).weight(.heavy))
                            .foregroundColor(Color("STR_White"))
                    }
                    .frame(width: 342,height: 60)
                    .offset(y: 150)
//                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .onTapGesture {
                        OnboardingViewModel.nextPage()
                    }
                }
            }
            .onAppear {
                UITabBar.appearance().barTintColor = UIColor(Color("STR_Green"))
            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onAppear {
                setupAppearance()
        }
       
    }
}
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black.withAlphaComponent(0.6)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
}
