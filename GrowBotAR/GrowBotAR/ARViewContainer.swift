//
//  ArViewContainer.swift
//  GrowBotAR
//
//  Created by Sorin Sebastian Mircea on 28/03/2020.
//  Copyright © 2020 Sorin Sebastian Mircea. All rights reserved.
//

import SwiftUI
import RealityKit
import PencilKit
import ARKit
import Vision


struct ARViewContainer: UIViewRepresentable {
    
    @Binding var overlayText: String
    
    func makeCoordinator() -> ARViewCoordinator{
        ARViewCoordinator(self, overlayText : $overlayText)
    }
    
    func makeUIView(context: Context) -> ARView {
        
        
        let arView = ARView(frame: .zero)
        arView.addCoaching()
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.run(config, options: [])
        
        arView.setupGestures()
        arView.session.delegate = context.coordinator
        
        // Add Scene
        let planetsAnchor = try! Experience.loadPlanets()
        arView.scene.anchors.append(planetsAnchor)
        
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}



class ARViewCoordinator: NSObject, ARSessionDelegate {
    var arVC: ARViewContainer
    
    @Binding var overlayText: String
    
    init(_ control: ARViewContainer, overlayText: Binding<String>) {
        self.arVC = control
        _overlayText = overlayText
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
    }
}


//MARK:- Custom Button SwiftUI
struct MyButtonStyle: ButtonStyle {
    var color: Color = .green
    
    public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
        
        configuration.label
            .foregroundColor(.white)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5).fill(color))
            .compositingGroup()
            .shadow(color: .black, radius: 3)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

//MARK:- PencilKit SwiftUI
struct PKCanvasRepresentation : UIViewRepresentable {
    
    let canvasView = PKCanvasView()
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvasView.tool = PKInkingTool(.pen, color: .secondarySystemBackground, width: 40)
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}

extension ARView{
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        guard let touchInView = sender?.location(in: self) else {
            return
        }
        
        rayCastingMethod(point: touchInView)
        let entities = self.entities(at: touchInView)
        
    }
    
    func rayCastingMethod(point: CGPoint) {
        
        
        guard let coordinator = self.session.delegate as? ARViewCoordinator else{ return }

        guard let raycastQuery = self.makeRaycastQuery(from: point,
                                                       allowing: .existingPlaneInfinite,
                                                       alignment: .horizontal) else {
                                                        
                                                        print("failed first")
                                                        return
        }
        
        guard let result = self.session.raycast(raycastQuery).first else {
            print("failed")
            return
        }
        
        let transformation = Transform(matrix: result.worldTransform)
//        let greenBox = CustomBox(color: .yellow)
//        self.installGestures(.all, for: greenBox)
//        greenBox.generateCollisionShapes(recursive: true)
//
//        let mesh = MeshResource.generateText(
//            "\(coordinator.overlayText)",
//            extrusionDepth: 0.1,
//            font: .systemFont(ofSize: 2),
//            containerFrame: .zero,
//            alignment: .left,
//            lineBreakMode: .byTruncatingTail)
//
//        let material = SimpleMaterial(color: .red, isMetallic: false)
//        let entity = ModelEntity(mesh: mesh, materials: [material])
//        entity.scale = SIMD3<Float>(0.03, 0.03, 0.1)
//
//        greenBox.addChild(entity)
//        greenBox.transform = transformation
//        //setting relative position...
//        entity.setPosition(SIMD3<Float>(0, 0.05, 0), relativeTo: greenBox)
        
//        let raycastAnchor = AnchorEntity(raycastResult: result)
//        raycastAnchor.addChild(greenBox)
//        self.scene.addAnchor(raycastAnchor)
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        coachingOverlayView.activatesAutomatically = false
        //Ready to add objects
    }
    
}
