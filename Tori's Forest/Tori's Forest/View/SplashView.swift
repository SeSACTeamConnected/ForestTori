//
//  SplashView.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//
import SwiftUI

struct SplashView: View {
    @ObservedObject var OnboardingViewModel : OnboardingViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                    Image("STR_Img_splash")
                        .resizable()
                        .ignoresSafeArea()
                }
                .onAppear {
                    if !NotificationManager.shared.isNotificationAuthorized() {
                        NotificationManager.shared.requestAuthorization()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeIn(duration: 1)) {
                            NotificationManager.shared.scheduleNotification()
                            OnboardingViewModel.nextPage()
                        }
                    }
                }
            }
        }
}
