//
//  ArViewContainer.swift
//  GrowBotAR
//
//  Created by Sorin Sebastian Mircea on 28/03/2020.
//  Copyright © 2020 Sorin Sebastian Mircea. All rights reserved.
//

import Foundation
import SwiftUI
import RealityKit

struct AugView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct AugView_Previews : PreviewProvider {
    static var previews: some View {
        AugView()
    }
}
#endif
