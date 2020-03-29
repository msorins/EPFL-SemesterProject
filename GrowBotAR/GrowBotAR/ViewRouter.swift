//
//  ViewRouter.swift
//  GrowBotAR
//
//  Created by Sorin Sebastian Mircea on 28/03/2020.
//  Copyright © 2020 Sorin Sebastian Mircea. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = "home" {
        didSet {
            objectWillChange.send(self)
        }
    }
    
}
