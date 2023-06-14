//
//  ARContentView.swift
//  Tori's Forest
//
//  Created by hyebin on 2023/06/14.
//

import SwiftUI

struct ARContentView: View {
    @Environment(\.presentationMode) var presentationMode
    let hapticImpact = UIImpactFeedbackGenerator()
    @Binding var chapterIndex: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                RealityKitView(chapterNumber: $chapterIndex)
                
                ZStack {
                    Rectangle()
                        .fill(.black)
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack{
                                Image(systemName: "chevron.backward")
                                Text("돌아가기")
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(width: 73, height: 22)
                        .foregroundColor(.white)
                        .padding(.top, 64)
                        .padding(.leading, 29)
                        .padding(.bottom, 64)
                        
                        Spacer(minLength: 34)
                        Button(action: {
                            captureScreen()
                            hapticImpact.impactOccurred()
                        }) {
                            Image(systemName: "button.programmable")
                                .resizable()
                                .font(.system(size: 16))
                                .frame(width: 64, height: 64)
                        }
                        .frame(width: 76, height: 96)
                        .foregroundColor(.white)
                        .padding(.top, 24)
                        .padding(.bottom, 30)
                        
                        Spacer()
                        
                        Button(action: {}) {
                        }
                        .frame(width: 100, height: 100)
                    }
                }
                .frame(height: 150)
                .edgesIgnoringSafeArea(.all)
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden()
    }
    
    func captureScreen() {
       let window = UIApplication.shared.windows.first { $0.isKeyWindow }
       if let window = window {
           let renderer = UIGraphicsImageRenderer(size: window.bounds.size)
           let image = renderer.image { _ in
               window.drawHierarchy( in: window.bounds, afterScreenUpdates: true)
           }
           let cropRect = CGRect(x: 0, y: 0, width: window.bounds.width, height: window.bounds.height - 180)
           if let croppedImage = cropImage(image, toRect: cropRect) {
               UIImageWriteToSavedPhotosAlbum(croppedImage, nil, nil, nil)
            }
        }
    }
    
    func cropImage(_ image: UIImage, toRect rect: CGRect) -> UIImage? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        let scaledRect = CGRect(
            x: rect.origin.x * image.scale,
            y: rect.origin.y * image.scale,
            width: rect.size.width * image.scale,
            height: rect.size.height * image.scale
        )
        
        if let croppedCGImage = cgImage.cropping(to: scaledRect) {
            return UIImage(cgImage: croppedCGImage, scale: image.scale, orientation: image.imageOrientation)
        }
        
        return nil
    }
}
