//
//  EndingView.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/15.
//

import SwiftUI

struct EndingView: View {
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
                Image("STR_Img_Onboarding_frezia")
                    .resizable()
                    .frame(width: 347, height: 195)
                    .padding(.bottom, 20)
                
                if introIndex == 0 {
                   
                    Text(username)
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_Green"))
                    
                    Text("정말 열심히 식물을 키워주었군요!\n정원이 예쁜 식물들로 가득해졌네요")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_brown"))
                        .multilineTextAlignment(.center)
                }
                
                else if introIndex == 1 {

                    Text("그런데, 여길 봐요!\n방금 새 싹을 틔운 화분 하나가 남아있어요")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_brown"))
                        .multilineTextAlignment(.center)
                }
                
                
                else if introIndex == 2 {
                    Text("사실, 이새싹은 바로")
                    HStack(spacing: 0){
                        Text(username)
                            .font(.system(size: 20).weight(.heavy))
                            .foregroundColor(Color("STR_Green"))
                        Text("당신이에요")
                            .font(.system(size: 20).weight(.heavy))
                            .foregroundColor(Color("STR_brown"))
                    }
                   
                }
                else if introIndex == 3 {
                    Text("이제는 토리의 숲을 벗어나\n더 넓은 세상에서 자라날 준비가 된 것 같네요.")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_brown"))
                        .multilineTextAlignment(.center)
                }
                else if introIndex == 4 {
                    Text("토리의 숲이 그리워질 때면,\n언제든 다시 찾아와요")
                        .font(.system(size: 20).weight(.heavy))
                        .foregroundColor(Color("STR_brown"))
                        .multilineTextAlignment(.center)
                    
                    
                    Button(action: {
                        print("이동해야함")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color("STR_brown"))
                            Text("좋아요")
                                .font(.system(size: 18).weight(.bold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 160, height: 50)
                }

                }
            }
        }
        .onAppear {
            if (introIndex == 0){
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    withAnimation(.linear(duration: 0.5)) {
                        self.introIndex = 1
                    }
                }
            }
            if (introIndex == 1){
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    withAnimation(.linear(duration: 0.5)) {
                        self.introIndex = 2
                    }
                }
            }
            if (introIndex == 2){
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    withAnimation(.linear(duration: 0.5)) {
                        self.introIndex = 3
                    }
                }
            }
            if (introIndex == 3){
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    withAnimation(.linear(duration: 0.5)) {
                        self.introIndex = 4
                    }
                }
            }
        }
    }
}
