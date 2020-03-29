//
//  PresentationContainer.swift
//  GrowBotAR
//
//  Created by Sorin Sebastian Mircea on 27/03/2020.
//  Copyright © 2020 Sorin Sebastian Mircea. All rights reserved.
//

import SwiftUI
import RealityKit

struct HomeView : View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                Spacer()
                
                VStack {
                    Text("GrowBot AR")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .colorScheme(.light)
                    
                    Button(action: {
                        self.viewRouter.currentPage = "aug"
                    }, label: {
                        Image(systemName: "arrowtriangle.right.circle")
                        Text("Start the experience")
                    })
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(5)
                }
                .frame(width: metrics.size.width * 0.60)
                .padding(25)
                .background(Color.white.opacity(0.7))
                .cornerRadius(5)
                
                
                
                Spacer()
            }
            .background(
                Image("cover")
                    .resizable()
                    .scaledToFill()
            )
                .scaledToFill()
        }
    }
}
