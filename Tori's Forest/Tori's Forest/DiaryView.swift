//
//  DiaryView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import Combine
import SwiftUI

struct DiaryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var posts: FetchedResults<Post>
    
    @Binding var isShowDiaryView: Bool
    @Binding var isMissionCompleted: Bool
    @Binding var isTapped: Bool
    @Binding var postIndex: Int
    
    @State private var imageDescription: String = ""
    @State private var descriptionDefault: String = "숲토리: 은둔청년을 위한 은둔 극복 프로젝트"
    @State private var isShowingActionSheet = false
    @State private var isShowingCameraPicker = false
    @State private var isShowingPhotoLibraryPicker = false
    @State private var selectedImage: UIImage? = nil ?? UIImage(named: "STR_Img_splash")!
    
    var chapterIndex: Int
    var missionIndex: Int
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Button(action: {
                        isShowDiaryView.toggle()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color("STR_Red"))
                            .cornerRadius(8)
                    }
                    Spacer()
                    Text("성장일지")
                        .foregroundColor(Color("STR_Black")) 
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        addPost(Int64(postIndex+1), Int64(chapterIndex+1), Int64(missionIndex+1), (selectedImage?.pngData()?.base64EncodedString())!, imageDescription == "" ? descriptionDefault : imageDescription, Date())

                        isShowDiaryView.toggle()
                        isMissionCompleted.toggle()
                        isTapped.toggle()
                    }) {
                        Text("완료")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color("STR_Green"))
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 30)
                .padding(.bottom, 10)
                
                VStack {
                    Button(action: {
                        isShowingActionSheet = true
                    }) {
                        if selectedImage == UIImage(named: "STR_Img_Splash") {
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 321, height: 321)
                                .clipped()
                                .cornerRadius(8)
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 321, height: 321)
                                .foregroundColor(Color.gray)
                                .opacity(0.2)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                )
                        }
                    }
                    .actionSheet(isPresented: $isShowingActionSheet) {
                        ActionSheet(title: Text("이미지 선택"), message: nil, buttons: [
                            .default(Text("사진 찍기"), action: {
                                isShowingCameraPicker = true
                            }),
                            .default(Text("이미지 선택"), action: {
                                isShowingPhotoLibraryPicker = true
                            }),
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $isShowingCameraPicker, onDismiss: loadImage) {
                        ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
                            .ignoresSafeArea()
                    }
                    .sheet(isPresented: $isShowingPhotoLibraryPicker, onDismiss: loadImage) {
                        ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                    }
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $imageDescription)
                            .scrollContentBackground(.hidden)
                            .background(Color("STR_White"))
                            .foregroundColor(Color("STR_Black"))
                            .padding()
                            .frame(minHeight: 87)
                            .frame(width: 322)
                            .foregroundColor(Color("STR_Black"))
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("STR_Brown").opacity(0.4), lineWidth: 2)
                                    .background(Color("STR_White"))
                            )
                            .onAppear {
                                UIApplication.shared.hideKeyboard()
                            }
                            .onChange(of: imageDescription) { newText in
                                if newText.last == "\n" {
                                    imageDescription.removeLast()
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }
                        
                        if imageDescription == "" {
                            Text("오늘의 활동과 감정을 적어보세요.")
                                .foregroundColor(Color("STR_Black").opacity(0.35))
                                .offset(x: 6, y: 7)
                                .padding()
                        }
                    }
                    .padding(10)
                    
                }
            }
        }
    }

    func loadImage() {
             // 이미지 선택 또는 사진 촬영 완료 후 호출되는 함수
             // 선택된 이미지를 처리하는 로직을 구현할 수 있습니다.
    }
    
    func addPost(_ id: Int64, _ chapterID: Int64, _ missionID: Int64, _ image: String, _ description: String, _ createdAt: Date) {
        let post = Post(context: viewContext)
        
        post.postID = id
        post.chapterID = chapterID
        post.missionID = missionID
        post.imageName = image
        post.postDescription = description
        post.createdAt = createdAt
        
        saveContext()
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

extension UIApplication {
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
 }
 
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

struct ImagePicker: UIViewControllerRepresentable {
     @Binding var selectedImage: UIImage?
     var sourceType: UIImagePickerController.SourceType = .photoLibrary

     func makeCoordinator() -> Coordinator {
         Coordinator(parent: self)
     }

     func makeUIViewController(context: Context) -> UIImagePickerController {
         let imagePickerController = UIImagePickerController()
         imagePickerController.delegate = context.coordinator
         imagePickerController.sourceType = sourceType
         return imagePickerController
     }

     func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

     class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
         let parent: ImagePicker

         init(parent: ImagePicker) {
             self.parent = parent
         }

         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
             if let selectedImage = info[.originalImage] as? UIImage {
                 parent.selectedImage = selectedImage
             }
             picker.dismiss(animated: true, completion: nil)
         }
         
     }
 }

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
//        DiaryView(showDiaryView: .constant(true))
        MainView()
    }
}
