//
//  CustomProgressBar.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct CustomProgressBar: View {
    let progress: CGFloat
    
    init(progress: CGFloat) {
        self.progress = progress
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 150, height: 30)
                    .foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 150, height: 30)
                    .foregroundColor(.green)
                    .scaleEffect(x: progress, y: 1.0, anchor: .leading)
            }
        }
    }
}

struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
