//
//  PlantCardView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/15.
//

import SwiftUI

struct PlantCardView: View {
    
    var header : String
    var plantName: String
    var imageName : String
    var description: String
    
    @Binding var showingPopup : Bool
    @Binding var isShowPlantSelectView: Bool
    @Binding var isEmpty: Bool
    
    var body: some View {
        VStack{
            Text("식물 친구를 선택해 주세요")
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("STR_White"))
                VStack(spacing: 1){
                    Text(header)
                        .font(.system(size: 18,weight:.semibold))
                        .foregroundColor(Color("STR_Green"))
                    
                    Text(plantName)
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundColor(Color("STR_Black"))
                    
                    Image(imageName)
                        .resizable()
                        .frame(width: 264,height: 209)
                        .cornerRadius(10)
                    
                    Text(description)
                        .font(.system(size:13))
                        .foregroundColor(Color("STR_Black"))
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("STR_brown"))
                        Text("선택하기")
                            .foregroundColor(Color("STR_White"))
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .onTapGesture {
                        showingPopup = false
                        isShowPlantSelectView.toggle()
                        isEmpty.toggle()
                    }
                    .frame(width: 265,height: 30)
                }
            }
            .frame(width: 306,height: 426)
        }
    }
}
