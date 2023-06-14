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

    @State var objectNames = ["dandelion", "cactus", "maple", "cotton"]

    var body: some View {
        var idx = objectNames.firstIndex(of: selectedViewName)
        
        ScrollView {
            VStack {
                Text(missions[(idx!)*3].missionHeader!)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color("STR_Brown"))
                Text(plants[(idx!)*3].plantName!)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color("STR_Green"))
//                Image("test")
//                Text(plants[(idx!)*3].plantDescription!)
                LazyVStack {
                    ForEach(posts) { item in
                        if item.chapterID == (idx!+1) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("STR_Brown").opacity(0.3), lineWidth: 2)
                                
                                VStack {
                                    Text(formatDate(item.createdAt!))
                                    Image(uiImage: UIImage(data: Data(base64Encoded: item.imageName!)!)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 321, height: 321)
                                        .clipped()
                                        .cornerRadius(8)
                                    Text(item.postDescription!)
                                }
                                .padding(.bottom)
                            }
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


