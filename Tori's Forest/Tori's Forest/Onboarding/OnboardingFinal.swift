//
//  OnboardingFinal.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/15.
//

import SwiftUI

struct OnboardingFinal: View {
    @AppStorage("username") var username: String = " "
    @ObservedObject var OnboardingViewModel : OnboardingViewModel
    @State private var introIndex = 0
    @State private var isNextView = false
    var accentText : String = "토리의 숲"
    var body: some View {
        ZStack{
            Image("STR_Img_bg_0_default")
                .resizable()
                .ignoresSafeArea()
                
            VStack(alignment: .center) {
                Image("STR_Img_ChapterThumbnail_1")
                    .resizable()
                    .frame(width: 347,height: 195)
                    .padding(.bottom,20)
                
                Text("첫 챕터는 새로운 시작을 의미하는\n새싹이 반짝이는 계절,봄이에요")
                    .font(.system(size: 16).weight(.heavy))
                    .foregroundColor(Color("STR_brown"))
                    .multilineTextAlignment(.center)
                HStack(spacing: 0){
                    Text(username)
                        .font(.system(size: 16).weight(.heavy))
                        .foregroundColor(Color("STR_Green"))
                    Text("의 시작을 응원할게요!")
                        .font(.system(size: 16).weight(.heavy))
                        .foregroundColor(Color("STR_brown"))
                    }
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color("STR_brown"))
                            Text("시작하기")
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 342,height: 60)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        .onTapGesture {
                            OnboardingViewModel.nextPage()
                        }
                            
                    }
                        
                }
            }
        }


struct OnboardingFinal_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFinal(OnboardingViewModel: OnboardingViewModel())
    }
}
