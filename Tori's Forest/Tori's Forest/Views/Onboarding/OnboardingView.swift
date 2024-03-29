//
//  OnboardingView.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var onboardingViewModel = OnboardingViewModel()
    var body: some View {
        VStack {
            if onboardingViewModel.currentPage == 1 {
                SplashView(OnboardingViewModel: onboardingViewModel)
            } else if onboardingViewModel.currentPage == 2 {
                Onboarding1(OnboardingViewModel: onboardingViewModel)
            } else if onboardingViewModel.currentPage == 3 {
                OnboardingTap(OnboardingViewModel: onboardingViewModel)
            } else if onboardingViewModel.currentPage == 4 {
                OnboardingAftertab(OnboardingViewModel: onboardingViewModel)
            } else if onboardingViewModel.currentPage == 5 {
                Onboarding2(OnboardingViewModel: onboardingViewModel)
            } else if  onboardingViewModel.currentPage == 6 {
                Onboarding3(OnboardingViewModel: onboardingViewModel)
            } else if  onboardingViewModel.currentPage == 7 {
                OnboardingFinal(OnboardingViewModel: onboardingViewModel)
            } else {
                MainView()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
