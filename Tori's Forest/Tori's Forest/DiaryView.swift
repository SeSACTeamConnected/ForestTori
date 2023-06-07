//
//  DiaryView.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct DiaryView: View {
    @Binding var showDiaryView: Bool
    @State private var imageDiscription : String =  ""
    @State private var isShowingActionSheet = false
    @State private var isShowingCameraPicker = false
    @State private var isShowingPhotoLibraryPicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
                    VStack {
                         HStack{
                                Button(action: {
                                 showDiaryView.toggle()
                             }) {
                                 Text("취소")
                             }
                             Spacer()
                             Button(action: {
                                 showDiaryView.toggle()
                             }) {
                                 Text("저장")
                             }
                         }
                         .padding()
                         Button(action: {
                                           isShowingActionSheet = true
                                          }) {
                                              if let image = selectedImage {
                                                  Image(uiImage: image)
                                                      .resizable()
                                                      .frame(maxWidth: .infinity)
//                                                      .frame(height: 187)
                                                      .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))
                                              } else {
                                                  RoundedRectangle(cornerRadius: 20)
                                                      .frame(maxWidth: .infinity)
//                                                      .frame(height: 187)
                                                      .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))
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
                                                    }
                                          .sheet(isPresented: $isShowingPhotoLibraryPicker, onDismiss: loadImage) {
                                                        ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                                                    }
                        HStack{
                            TextField("오늘 하루 어땠나요?",text: $imageDiscription)
                                .padding()
//                                .frame(height: 224)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)
                            }
                            .padding()
                                          
                                      }
//                                      )
                                  }
//                              }

    func loadImage() {
             // 이미지 선택 또는 사진 촬영 완료 후 호출되는 함수
             // 선택된 이미지를 처리하는 로직을 구현할 수 있습니다.
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
