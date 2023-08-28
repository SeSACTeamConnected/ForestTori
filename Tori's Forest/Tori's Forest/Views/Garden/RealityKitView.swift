//
//  RealityKitView.swift
//  Tori's Forest
//
//  Created by hyebin on 2023/06/14.
//

import ARKit
import RealityKit
import SwiftUI
// spm: https://github.com/maxxfrazer/FocusEntity
import FocusEntity

struct RealityKitView: UIViewRepresentable {
    @Binding var chapterNumber: Int
    
    func makeUIView(context: Context) -> ARView {
        let view = ARView()
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.isLightEstimationEnabled = true

        config.planeDetection = [.horizontal]
        session.run(config)
        
        context.coordinator.view = view
        session.delegate = context.coordinator
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        return view
    }

    func updateUIView(_ view: ARView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?
        var isObjectPlaced = false
        let parent: RealityKitView
        let fileName = ["ground_none", "ground_dandelion", "ground_cactus", "ground_maple", "ground_cottontree"]
        
        init(_ parent: RealityKitView) {
            self.parent = parent
        }

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            if !isObjectPlaced && focusEntity == nil {
                self.focusEntity = FocusEntity(on: view, style: .classic())
            }
        }
        
        @objc func handleTap() {
            if !isObjectPlaced {
                isObjectPlaced = true
                guard let view = self.view,
                      let focusEntity = self.focusEntity
                else { return }

                let anchor = AnchorEntity()
                view.scene.anchors.append(anchor)
             
                let modelEntity = try! ModelEntity.loadModel(named: fileName[parent.chapterNumber])
                modelEntity.scale = [0.05, 0.05, 0.05]
                modelEntity.position = focusEntity.position
                modelEntity.generateCollisionShapes(recursive: true)
                anchor.addChild(modelEntity)

                view.installGestures([.rotation, .scale], for: modelEntity)
                
                focusEntity.destroy()
                focusEntity.isEnabled = false
                focusEntity.isAccessibilityElement = false
                focusEntity.removeFromParent()
                self.focusEntity = nil
            }
        }
    }
}
