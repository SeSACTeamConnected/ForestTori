//
//  PlantSceneView.swift
//  Tori's Forest
//
//  Created by hyebin on 2023/06/08.
//

import SwiftUI
import SceneKit

struct PlantSceneView: UIViewRepresentable {
    let sceneView = SCNView()
    @Binding var sceneViewName: String
    
    func makeUIView(context: Context) -> SCNView {
        sceneView.backgroundColor = .clear
        sceneView.scene = SCNScene(named: sceneViewName)
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.defaultCameraController.maximumVerticalAngle = 0.001
        
        for gestureRecognizer in sceneView.gestureRecognizers ?? [] {
            if !(gestureRecognizer is UIPanGestureRecognizer) {
                gestureRecognizer.isEnabled = false
            }
        }
        
        return sceneView
    }
    
    func updateUIView(_ scnView: SCNView, context: Context) {
        scnView.scene = SCNScene(named: sceneViewName)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject {
        let parent: PlantSceneView
        
        init(_ parent: PlantSceneView) {
            self.parent = parent
        }
        
    }
}
