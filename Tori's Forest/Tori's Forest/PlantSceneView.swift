//
//  PlantSceneView.swift
//  Tori's Forest
//
//  Created by hyebin on 2023/06/08.
//

import SwiftUI
import SceneKit

struct PlantSceneView: UIViewRepresentable {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var plants: FetchedResults<Plant>
    
    let sceneView = SCNView()
    
//    @Binding var sceneViewName: String
    var sceneViewName: String
    
    func makeUIView(context: Context) -> SCNView {
        sceneView.backgroundColor = .clear
        sceneView.scene = SCNScene(named: sceneViewName)
        sceneView.scene?.rootNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.defaultCameraController.maximumVerticalAngle = 30
        
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
