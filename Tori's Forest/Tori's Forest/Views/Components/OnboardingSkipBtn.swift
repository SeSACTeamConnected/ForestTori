//
//  OnboardingSkipBtn.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/14.
//

import SwiftUI

struct OnboardingSkipBtn: View {
    @ObservedObject var OnboardingViewModel: OnboardingViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                OnboardingViewModel.skipPage()
            } label: {
                HStack {
                    Text("Skip")
                        .font(.system(size: 16))
                        .foregroundColor(Color("STR_brown"))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16))
                        .foregroundColor(Color("STR_brown"))
                }
                .frame(alignment: .leading)
               
            }
        }
       
    }
}
