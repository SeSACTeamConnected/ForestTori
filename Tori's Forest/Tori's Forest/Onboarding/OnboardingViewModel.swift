//
//  OnboardingViewModel.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    
    func nextPage() {
        currentPage += 1
    }
    
    func skipPage() {
        currentPage = 4
    }
    
    func previousPage() {
        currentPage -= 1
    }
}


