//
//  Onboarding2.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//

import SwiftUI
import Combine
extension String {
    func containKorean() -> Bool {
        let koreanPattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣]*$"
               if let regex = try? NSRegularExpression(pattern: koreanPattern) {
                   return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
               }
               return false
    }
    
}

struct Onboarding2: View {
    @ObservedObject var OnboardingViewModel : OnboardingViewModel
    @AppStorage("username") var username: String = ""
    @State private var introIndex = 0
    @State private var isNextView = false
    let intro : [String] = ["안녕하세요,\n여기는 토리의 숲이에요","마법이 있어야만\n자랄 수 있어요"]
    let maxCharacterLength = Int(8)
    @State var name: String = ""
    
    var body: some View {
        ZStack{
                Image("STR_Img_bg_0_default")
                    .resizable()
                    .ignoresSafeArea()
            
                VStack{
                    Spacer()
                    
                    VStack(alignment: .leading,spacing: 0){
                        Text("내 이름은")
                            .font(.system(size: 14))
                            .foregroundColor(Color("STR_Brown"))
                            .frame(alignment: .leading)
                        
                        HStack(spacing: 0){
                            TextField("이름을 입력하세요", text: $name)
                                .onChange(of: name) {
                                    newValue in if name.count > 9{
                                        name = String(name.prefix(9))
                                    }
                                }
                                .foregroundColor(name.count > 8 ? Color("STR_Red") : Color("STR_Green"))
                                .frame(width: 160)
                                .multilineTextAlignment(.trailing)
                                .underline(color: name.count == 0 ? Color("STR_Brown") : name.count > 8 ? Color("STR_Red") : Color("STR_Green"))
                                .fixedSize()
                                .onReceive(Just(name), perform: { _ in
                                    if name.containKorean() == false {
                                        name = String(name.dropLast())
                                    }
                                    print(name.containKorean())
                                })
                            
                            Text("토리")
                                .foregroundColor(Color("STR_Brown"))
                                .padding(.leading,7)
                        }
                        .font(.system(size: 22, weight: .heavy))
                        .padding(.top, 6)
                       
                        Text("8자 이하만 가능해요.")
                            .foregroundColor(name.count > 8 ? .red : .clear)
                            .font(.system(size: 12))
                            .frame(alignment: .leading)
                            .padding(.top, 6)
            
                    }
                    
                    Spacer()
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(name.count > 0 && name.count < 9 ? Color.clear : Color("STR_Brown"), lineWidth: 2)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .fill(name.count > 0 && name.count < 9 ? Color("STR_Brown") : Color.clear)
                        
                        
                        Text("이름 알려주기")
                            .font(.system(size: 18).weight(.bold))
                            .foregroundColor(name.count > 0 && name.count < 9 ? Color("STR_White") : Color("STR_Brown"))
                    }
                    .frame(width: 342, height: 60)
                    .onTapGesture {
                        if(name.count > 0 && name.count < 9){
                            username = name
                            OnboardingViewModel.nextPage()
                        }
                        print(username)
                }
            }
        }
    }
}

struct Onboarding2_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding2(OnboardingViewModel: OnboardingViewModel())
    }
}


