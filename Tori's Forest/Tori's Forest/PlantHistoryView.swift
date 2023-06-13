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
    var posts: FetchedResults<Post>

    @Binding var selectedViewName: String

    @State var objectNames = ["dandelion", "cactus", "maple", "cotton"]

    var body: some View {
        var idx = objectNames.firstIndex(of: selectedViewName)
        
        ScrollView {
            VStack {
                Text(chapters[idx!].chapterHeader!)
                Text(plants[(idx!)*3].plantName!)
                Image("test")
                Text(plants[(idx!)*3].plantDescription!)
                LazyVStack {
                    ForEach(posts) { item in
                        if item.chapterID == (idx!+1) {
                            HStack {
                                Image(uiImage: UIImage(data: Data(base64Encoded: item.imageName!)!)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                VStack {
                                    Text(item.postDescription!)
                                    Text(formatDate(item.createdAt!))
                                }
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
        dateFormatter.dateFormat = "yyyyMMdd"

        return dateFormatter.string(from: date)
    }
}

struct PlantHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView(chapterIndex: .constant(0), plantIndex: .constant(0), postIndex: .constant(0))
    }
}
