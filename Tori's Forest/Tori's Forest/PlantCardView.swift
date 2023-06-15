//
//  PlantCardView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/15.
//
import SwiftUI

struct PlantCardView: View {
    var header: String
    var plantName: String
    var imageName: String
    var description: String
    
    @Binding var showingPopup: Bool
    @Binding var isShowPlantSelectView: Bool
    @Binding var isEmpty: Bool
    
    var isClickable: Bool {
        let clickablePlants = ["민들레씨", "작은 선인장", "단풍나무", "목화나무"]
        return clickablePlants.contains(plantName)
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("STR_White"))
                
                VStack(spacing: 1) {
                    Text(header)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("STR_Green"))
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    
                    Text(plantName)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color("STR_Black"))
                        .padding(.bottom, 5)
                    
                    Image(imageName)
                        .resizable()
                        .frame(width: 264, height: 209)
                        .cornerRadius(8)
                    
                    Text(description)
                        .font(.system(size: 13))
                        .foregroundColor(Color("STR_Black"))
                        .padding()
                        .lineSpacing(1)
//                        .padding(.bottom, 3)
                        .padding(.horizontal, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        showingPopup = false
                        isShowPlantSelectView.toggle()
                        isEmpty.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(isClickable ? Color("STR_Brown") : Color.gray.opacity(0.5))
                                .frame(width: 263, height: 35)
                            Text("선택하기")
                                .foregroundColor(Color("STR_White"))
                                .font(.system(size: 14, weight: .bold))
                        }
                    }
                    .disabled(!isClickable)
                    .padding(.bottom, 15)
                }
            }
            .frame(width: 306, height: 426)
        }
    }
}
