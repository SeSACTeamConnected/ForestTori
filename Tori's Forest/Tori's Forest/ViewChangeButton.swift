//
//  ViewChangeButton.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/04.
//

import SwiftUI

struct ViewChangeButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var posts: FetchedResults<Post>
    
    @Binding var chapterIndex: Int
    @Binding var plantIndex: Int
    @Binding var postIndex: Int
    @Binding var viewName: String
    
    var body: some View {
            NavigationLink(
                destination: destinationView
                    .environment(\.managedObjectContext, viewContext)
                    .navigationBarBackButtonHidden()
            ) {
                Image(viewName == "Main" ? "STR_Img_asset_button_main" : "STR_Img_asset_button_garden")
                    .resizable()
                    .frame(width: 45, height: 45)            }
        }
    
    @ViewBuilder
    private var destinationView: some View {
        Group {
            if viewName == "Main" {
                GardenView(chapterIndex: $chapterIndex, plantIndex: $plantIndex, postIndex: $postIndex)
            } else {
                MainView()
            }
        }
    }
}

struct ViewChangeButton_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
