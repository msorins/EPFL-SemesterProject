//
//  ContentView.swift
//  GrowBotAR
//
//  Created by Sorin Sebastian Mircea on 27/03/2020.
//  Copyright © 2020 Sorin Sebastian Mircea. All rights reserved.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @ObservedObject var viewRouter: ViewRouter
    @State var test: String = "Hi"
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "home" {
                HomeView(viewRouter: viewRouter)
            } else if viewRouter.currentPage == "aug" {
                ARViewContainer(overlayText: $test)
            }
        }
        .padding(0.0)
        .edgesIgnoringSafeArea(.all)
    }
    
}


struct Content_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}
