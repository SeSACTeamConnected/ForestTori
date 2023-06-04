//
//  ViewChangeButton.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct ViewChangeButton: View {
    @Binding var viewName: String
    
    var body: some View {
        Button {
            print("View is changed.")
        } label: {
            Text(viewName=="Main" ? "정원" : "메인")
        }
    }
}

struct ViewChangeButton_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
