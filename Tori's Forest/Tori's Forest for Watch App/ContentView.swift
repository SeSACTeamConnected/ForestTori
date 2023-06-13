//
//  ContentView.swift
//  Tori's Forest for Watch App
//
//  Created by hyebin on 2023/06/13.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModelWatch()
    
    private var currentDate: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "MM dd EEEE"
        let d = formatter.string(from: Date())
        return d.split(separator: " ").map{String($0)}
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    Text("\(currentDate[2])")
                        .font(.system(size: 20, weight: .semibold))
                        .tint(Color("STR_White"))
                    Image("forest")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .padding(.bottom, -8)
                Text("\(currentDate[0]).\(currentDate[1])")
                    .tint(Color("STR_White"))
                    .font(.system(size: 35, weight: .semibold))
            }
            .padding(.top, 10)
            .padding(.leading, 10)
            .padding(.bottom, -30)
            .scaledToFit()
            .ignoresSafeArea(.all)
            List {
                ForEach(model.messageText.sorted(by: >), id: \.key) {key, value in
                    VStack(alignment: .leading) {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 5)
                                .colorMultiply(Color("ListPlantName"))
                                .frame(width: 60, height: 24)
                            Text("\(key)")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                        }
                        .padding(.top, 6)
                        
                        Text("\(value)")
                            .foregroundColor(Color("ListRowForegroundColor"))
                            .font(.system(size: 18, weight: .heavy))
                            .padding(.leading, 2)
                    }
                    .listRowBackground(Color("ListRowBackground").cornerRadius(10))
                    .listRowInsets(EdgeInsets(top: 2, leading: 9.44, bottom: 5, trailing: 9.44))
                
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
