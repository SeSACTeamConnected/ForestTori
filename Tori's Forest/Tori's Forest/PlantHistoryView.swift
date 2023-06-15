//
//  PlantHistoryView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct PlantHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [])
    var chapters: FetchedResults<Chapter>

    @FetchRequest(sortDescriptors: [])
    var plants: FetchedResults<Plant>
    
    @FetchRequest(sortDescriptors: [])
    var missions: FetchedResults<Mission>

    @FetchRequest(sortDescriptors: [])
    var posts: FetchedResults<Post>

    @Binding var selectedViewName: String
    
    @State var objectNames: Array<String> = ["dandelion", "cactus", "maple", "cottontree"]

    var body: some View {
        let idx = objectNames.firstIndex(of: selectedViewName)
        let backgrounds: Array<String> = ["STR_Img_bg_1_spring", "STR_Img_bg_2_summer", "STR_Img_bg_3_autumn", "STR_Img_bg_4_winter"]
        
        ScrollView {
            VStack {
                Text(missions[(idx!)*3].missionHeader!)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color("STR_Brown"))
                    .padding(.top, 30)
                    .padding(.bottom, 1)
                
                Text(plants[(idx!)*3].plantName!)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color("STR_Green"))
                    .padding(.bottom, 10)
                
                ZStack {
                    Image(backgrounds[idx!])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 336.47, height: 334.31)
                        .clipped()
                        .cornerRadius(10)
                    
                    PlantSceneView(sceneViewName: plants[(idx!)*3].objectName!)
                        .frame(width: 200, height: 300)
                }
                .padding(.bottom, 3)
                
                LazyVStack {
                    ForEach(posts) { item in
                        if item.chapterID == (idx!+1) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("STR_Brown").opacity(0.3), lineWidth: 2)
                                    .frame(width: 336.47)
                                
                                VStack {
                                    Text(formatDate(item.createdAt!))
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color("STR_Black"))
                                        .frame(width: 303, alignment: .leading)
                                        .padding(.top)
                                    
                                    if item.imageName! != "blank" {
                                        Image(uiImage: UIImage(data: Data(base64Encoded: item.imageName!)!)!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .rotationEffect(Angle(degrees: 90))
                                            .frame(width: 302.97, height: 302.97)
                                            .clipped()
                                            .cornerRadius(8)
                                            .padding(.bottom, 3)
                                    } else {
                                        Image(uiImage: UIImage(named: "STR_Img_splash")!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 302.97, height: 302.97)
                                            .clipped()
                                            .cornerRadius(8)
                                            .padding(.bottom, 3)
                                    }
                                    
                                    Text(item.postDescription!)
                                        .foregroundColor(Color("STR_Black"))
                                        .lineSpacing(1)
                                        .frame(width: 303, alignment: .leading)
                                        .padding(.top, 3)
                                    
                                }
                                .padding(.bottom)
                            }
                            .padding(.bottom, 10)
                        }
                    }
                }
                .padding()
            }
        }
    }

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"

        return dateFormatter.string(from: date)
    }
}


