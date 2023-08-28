//
//  SplashView.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//
import SwiftUI
import CoreData
struct SplashView: View {
    @ObservedObject var OnboardingViewModel: OnboardingViewModel
    @AppStorage("chapterIndex") var chapterIndex: Int = 0
    @AppStorage("plantIndex") var plantIndex: Int = 0
    @AppStorage("dialogIndex") var dialogIndex: Int = 0
    @AppStorage("missionIndex") var missionIndex: Int = 0
    @AppStorage("postIndex") var postIndex: Int = 0
    
    @ObservedObject var model = ViewModelPhone()
    
    var body: some View {
        VStack {
            ZStack {
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
//                            NotificationManager.shared.scheduleNotification()
                            OnboardingViewModel.nextPage()
                        }
                    }
                }
        }
        .onAppear {
            chapterIndex = 0
            plantIndex = 0
            dialogIndex = 0
            missionIndex = 0
            postIndex = 0
            
            CoreDataManager.coreDM.deleteAllDataFromAllEntities()
            CoreDataManager.coreDM.loadData()
        }
    }
}
