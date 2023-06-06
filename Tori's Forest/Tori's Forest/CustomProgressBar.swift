//
//  CustomProgressBar.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct CustomProgressBar: View {
    //    @State var progress: CGFloat = 0.0
    
    @Binding var plantStage: Int
    @Binding var days: Int
    
    var body: some View {
        let progress = CGFloat(plantStage) / CGFloat(days)
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
